//
//  MasterViewController.h
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "ToDo.h"
#import "NewItemViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NewItemViewController *nItemViewController;

@end

