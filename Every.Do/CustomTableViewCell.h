//
//  CustomTableViewCell.h
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *customToDoLabel;
@property (strong, nonatomic) IBOutlet UILabel *customItemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *customPriorityLabel;

@end
