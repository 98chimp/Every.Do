//
//  NewItemViewController.m
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "NewItemViewController.h"

@interface NewItemViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nItemTitle;
@property (strong, nonatomic) IBOutlet UITextView *nItemDescription;
@property (strong, nonatomic) IBOutlet UISegmentedControl *nItemPriority;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) ToDo *draftToDo;
@property (strong, nonatomic) NSMutableArray *draftToDos;

- (IBAction)saveButton:(UIBarButtonItem *)sender;

@end

@implementation NewItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.draftToDos) {
        self.draftToDos = [[NSMutableArray alloc] init];
        self.draftToDo = [[ToDo alloc] init];
    }
    else {
        self.draftToDos = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
        self.draftToDo = self.draftToDos[0];
        self.nItemTitle.text = self.draftToDo.title;
        self.nItemDescription.text = self.draftToDo.description;
        self.nItemPriority.selectedSegmentIndex = self.draftToDo.priority;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) return;
    if (self.nItemTitle.text.length > 0) {
        self.toDo = [[ToDo alloc] init];
        self.toDo.title = self.nItemTitle.text;
        self.toDo.itemDescription = self.nItemDescription.text;
        self.toDo.priority = self.nItemPriority.selectedSegmentIndex;
        self.toDo.isCompleted = NO;
    }
}

-(NSString*)getFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
}

- (void)updateAllObjects
{
    [NSKeyedArchiver archiveRootObject:self.draftToDos toFile:[self getFilePath]];
}

- (void)insertNewObject:(ToDo *)draftToDo
{
    [self.draftToDos addObject:draftToDo];
    [NSKeyedArchiver archiveRootObject:self.draftToDos toFile:[self getFilePath]];
}

- (void)deleteObject:(ToDo *)draftToDo
{
    [self.draftToDos removeObject:draftToDo];
    [NSKeyedArchiver archiveRootObject:self.draftToDos toFile:[self getFilePath]];
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"SaveItem" sender:self];
}

- (IBAction)titleTextField:(UITextField *)sender
{
    [self updateAllObjects];
}

- (IBAction)prioritySelector:(UISegmentedControl *)sender
{
    [self updateAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField andTextView:(UITextView *)textView
{
    if(textField.returnKeyType==UIReturnKeyNext) {
        UIView *next = [[textView superview] viewWithTag:textView.tag+1];
        [next becomeFirstResponder];
    } else if (textView.returnKeyType==UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
