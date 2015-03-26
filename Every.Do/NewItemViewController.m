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
- (IBAction)saveButton:(UIBarButtonItem *)sender;

@end

@implementation NewItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
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


- (IBAction)saveButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"SaveItem" sender:self];
}

@end
