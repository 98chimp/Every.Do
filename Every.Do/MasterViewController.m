//
//  MasterViewController.m
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property (strong, nonatomic) NSArray *savedToDos;
@property (strong, nonatomic) NSMutableArray *toDoItems;

- (IBAction)addNewItem:(UIBarButtonItem *)sender;


@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *firstName = [defaults objectForKey:@"firstName"];
//    NSString *lastName = [defaults objectForKey:@"lastname"];
//    
//    int age = [defaults integerForKey:@"age"];
//    NSString *ageString = [NSString stringWithFormat:@"%i",age];
//    
//    NSData *imageData = [defaults dataForKey:@"image"];
//    UIImage *contactImage = [UIImage imageWithData:imageData];
//    
//    // Update the UI elements with the saved data
//    firstNameTextField.text = firstName;
//    lastNameTextField.text = lastName;
//    ageTextField.text = ageString;
//    contactImageView.image = contactImage;
//    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.savedToDos = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    if (self.savedToDos) {
        self.toDoItems = [self.savedToDos mutableCopy];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)insertNewObject:(ToDo *)toDo
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.toDoItems addObject:toDo];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
    [self.tableView reloadData];
    
}

- (void)deleteObject:(ToDo *)toDo
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.toDoItems removeObject:toDo];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
    [self.tableView reloadData];
}

- (void)updateAllObjects
{
    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
    [self.tableView reloadData];
}

-(NSString*)getFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = self.toDoItems[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    NewItemViewController *source = [segue sourceViewController];
    ToDo *item = source.toDo;
    if (item != nil) {
        if (!self.toDoItems) {
            self.toDoItems = [[NSMutableArray alloc] init];
        }
    }
    [self insertNewObject:item];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
    
    cell.customItemDescriptionLabel.text = toDo.itemDescription;
    switch (toDo.priority) {
        case 0:
            cell.customPriorityLabel.text = @"";
            break;
        case 1:
            cell.customPriorityLabel.text = @"!";
            cell.customPriorityLabel.textColor = [UIColor orangeColor];
            break;
        case 2:
            cell.customPriorityLabel.text = @"!!";
            cell.customPriorityLabel.textColor = [UIColor orangeColor];
            break;
        case 3:
            cell.customPriorityLabel.text = @"!!!";
            cell.customPriorityLabel.textColor = [UIColor orangeColor];
            break;
        default:
            cell.customPriorityLabel.text = @"";
            break;
    }
    if (toDo.isCompleted) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:cell.customToDoLabel.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        
        cell.customToDoLabel.attributedText = attributeString;
    }
    else {
        cell.customToDoLabel.text = toDo.title;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *completedAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Done" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
        toDo.isCompleted = YES;
        [self updateAllObjects];
    }];
    
    UITableViewRowAction *outstandingAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Undo" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
        toDo.isCompleted = NO;
        [self updateAllObjects];
    }];
    
    outstandingAction.backgroundColor = [UIColor lightGrayColor];
    completedAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
        [self deleteObject:toDo];
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
    if (toDo.isCompleted == YES) {
        return @[deleteAction, outstandingAction];
    }
    else {
        return @[deleteAction, completedAction];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (IBAction)addNewItem:(UIBarButtonItem *)sender
{
}

@end
