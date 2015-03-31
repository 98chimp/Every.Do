//
//  ToDo.h
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject<NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *itemDescription;
@property (assign, nonatomic) NSInteger priority;
@property (assign, nonatomic) bool isCompleted;

@end
