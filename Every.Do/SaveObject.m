//
//  SaveObject.m
//  Every.Do
//
//  Created by Shahin on 2015-03-30.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "SaveObject.h"

@implementation SaveObject
//
//- (instancetype)initWithToDo:(ToDo *)toDo masterViewController:(MasterViewController *)masterVC
//{
//    self = [super init];
//    if (self) {
//        self.toDo = toDo;
//        self.masterVC = masterVC;
//    }
//    return self;
//}
//
//+ (void)insertNewObject:(ToDo *)toDo {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.toDoItems addObject:toDo];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
//    [self.tableView reloadData];
//    
//}
//
//+ (void)deleteObject:(ToDo *)toDo {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.toDoItems removeObject:toDo];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
//    [self.tableView reloadData];
//}
//
//+ (void)updateAllObjects {
//    [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self getFilePath]];
//    [self.tableView reloadData];
//}
//
@end
