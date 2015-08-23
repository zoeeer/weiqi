//
//  Settings.h
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Game.h"

# define DefaultBoardSize 19
# define DefaultShowHistory false
# define Key_ShowHistory @"Default Show History"
# define Key_BoardSize @"Default Board Size"

@interface Settings : NSObject

@property (assign) NSInteger board_size;
@property (assign) GameMode mode;    // 0: man-man; 1: man-machine; 2: machine-man
@property (assign) NSInteger handicap;
@property (assign) NSInteger komi;
@property (assign) BOOL showHistory;
@end
