//
//  ToDo.m
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString *)title itemDescription:(NSString *)itemDescription priority:(NSInteger)priority isCompleted:(BOOL)isCompleted
{
    self = [super init];
    if (self) {
        self.title = title;
        self.itemDescription = itemDescription;
        self.priority = priority;
        self.isCompleted = isCompleted;
    }
    return self;
}

@end
