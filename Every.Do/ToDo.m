//
//  ToDo.m
//  Every.Do
//
//  Created by Shahin on 2015-03-25.
//  Copyright (c) 2015 98% Chimp. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.itemDescription = [decoder decodeObjectForKey:@"itemDescription"];
        self.priority = [decoder decodeIntForKey:@"priority"];
        self.isCompleted = [decoder decodeBoolForKey:@"isCompleted"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.itemDescription forKey:@"itemDescription"];
    [encoder encodeInteger:self.priority forKey:@"priority"];
    [encoder encodeBool:self.isCompleted forKey:@"isCompleted"];
}

@end
