//
//  Settings.m
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "Settings.h"

@implementation Settings

- (void) dealloc
{
    NSLog(@"settings will dealloc");
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setBoard_size:9];
    }
    return self;
}

@end
