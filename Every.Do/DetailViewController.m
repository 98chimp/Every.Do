//
//  DetailViewController.m
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *detailedToDoTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailedItemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailedPriorityLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailedToDoTitleLabel.text = self.detailItem.title;
        self.detailedItemDescriptionLabel.text = self.detailItem.itemDescription;
        switch (self.detailItem.priority) {
            case 0:
                self.detailedPriorityLabel.text = @"";
                break;
            case 1:
                self.detailedPriorityLabel.text = @"!";
                self.detailedPriorityLabel.textColor = [UIColor orangeColor];
                break;
            case 2:
                self.detailedPriorityLabel.text = @"!!";
                self.detailedPriorityLabel.textColor = [UIColor orangeColor];
                break;
            case 3:
                self.detailedPriorityLabel.text = @"!!!";
                self.detailedPriorityLabel.textColor = [UIColor orangeColor];
                break;
            default:
                self.detailedPriorityLabel.text = @"";
                break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
