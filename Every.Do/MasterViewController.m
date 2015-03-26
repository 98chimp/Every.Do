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
- (IBAction)addNewItem:(UIBarButtonItem *)sender;

@property NSMutableArray *toDoItems;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    ToDo *toDo1 = [[ToDo alloc] initWithTitle:@"pick up book from library"
                              itemDescription:@"Nowhere to Hide by Greg Greenwald"
                                     priority:1
                                  isCompleted:NO];
    
    ToDo *toDo2 = [[ToDo alloc] initWithTitle:@"pick up kids from school"
                              itemDescription:@"Kids will be at Treehouse for a workshop on Salmon lifecycle"
                                     priority:3
                                  isCompleted:NO];
    
    ToDo *toDo3 = [[ToDo alloc] initWithTitle:@"phone shawn"
                              itemDescription:@"Discuss app project and storyboard deadline"
                                     priority:1
                                  isCompleted:NO];
    
    ToDo *toDo4 = [[ToDo alloc] initWithTitle:@"call Pasha & Arash"
                              itemDescription:@"Discuss RealEyes project with the Boston team"
                                     priority:1
                                  isCompleted:NO];
    
    ToDo *toDo5 = [[ToDo alloc] initWithTitle:@"set up a meeting with Soush"
                              itemDescription:@"review concept note and turn them into product requirements"
                                     priority:2
                                  isCompleted:NO];
    
    ToDo *toDo6 = [[ToDo alloc] initWithTitle:@"buy movie tickets"
                              itemDescription:@"discuss time with Elly and kids"
                                     priority:0
                                  isCompleted:NO];
    
    self.toDoItems = [NSMutableArray arrayWithObjects:toDo1, toDo2, toDo3, toDo4, toDo5, toDo6, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.toDoItems) {
        self.toDoItems = [[NSMutableArray alloc] init];
    }
    
    [self.toDoItems insertObject:self.nItemViewController.toDo atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = self.toDoItems[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    NewItemViewController *source = [segue sourceViewController];
    ToDo *item = source.toDo;
    if (item != nil) {
        if (!self.toDoItems) {
            self.toDoItems = [[NSMutableArray alloc] init];
        }
        [self.toDoItems insertObject:item atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *completedAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Done" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        // translate from index path to task object
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
        
        // update the task object completed flag
        toDo.isCompleted = YES;
        
        // tell the tableview to reload.
        [self.tableView reloadData];
        
    }];
    
    UITableViewRowAction *outstandingAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Undo" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        // translate from index path to task object
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];

        // update the task object completed flag
        toDo.isCompleted = NO;

        // tell the tableview to reload.
        [self.tableView reloadData];
        
    }];
    
    outstandingAction.backgroundColor = [UIColor redColor];
    completedAction.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.2 alpha:1];
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
        [self.toDoItems removeObject:toDo];
        [self.tableView reloadData];
    }];
    
    deleteAction.backgroundColor = [UIColor colorWithRed:0.6 green:0 blue:0 alpha:1];
    
    ToDo *toDo = [self.toDoItems objectAtIndex:indexPath.row];
    
    if (toDo.isCompleted == YES) {
        return @[deleteAction, outstandingAction];
    }
    else {
        return @[deleteAction, completedAction];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (IBAction)addNewItem:(UIBarButtonItem *)sender {
}
@end
