//
//  SaveObject.h
//  Every.Do
//
//  Created by Shahin on 2015-03-30.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDo.h"
@class MasterViewController;

@interface SaveObject : NSObject

@property (weak, nonatomic) ToDo *toDo;
@property (weak, nonatomic) MasterViewController *masterVC;

+ (void)insertNewObject:(ToDo *)toDo;
+ (void)deleteObject:(ToDo *)toDo;
+ (void)updateAllObjects;

@end
