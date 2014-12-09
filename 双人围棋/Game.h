//
//  Game.h
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Settings.h"

typedef enum {
    BLACK,
    WHITE,
    NONE = -1,
} Color;

@interface Player : NSObject
{
    NSString *name;
    Color color;
    Player *next;
}
@property (strong) NSString *name;
@property Color color;
@property (weak) Player *next;

@end

@interface Game : NSObject
{
    NSInteger handicap;
    Player *player1;
    Player *player2;
    Player *currentplayer;
}
//@property (assign) Settings* settings;
@property (strong) Player *player1;
@property (strong) Player *player2;
@property (weak) Player *currentplayer;

@end
