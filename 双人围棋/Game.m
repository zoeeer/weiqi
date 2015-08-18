//
//  Game.m
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "Game.h"
#import "Settings.h"

/**********************************************
 ****                Record                ****
 **********************************************/
@interface Record ()
@property (readwrite) StoneViewController *stoneVC;
@property (readwrite) NSArray *captured;
@end

@implementation Record

- (instancetype)initWithCurrentMove:(StoneViewController*)stonevc CapturedArray:(NSArray*)capturedArray
{
    if (self = [super init]) {
        [self setStoneVC:stonevc];
        [self setCaptured:capturedArray];
    }
    return self;
}
@end
/**********************************************
 ****                Player                ****
 **********************************************/

@implementation Player

- (instancetype)init
{
    if (self = [super init]) {
        [self setColor:NONE];
    }
    return self;
}

- (instancetype)initWithColor:(Color)color
{
    if (self = [super init]) {
        [self setColor:color];
    }
    return self;
}

- (GameState)move
{
    return WAIT_INPUT;
}
@end

@implementation Game

- (id)initWithSettings:(Settings *)settings
{
    [self setBoardsize:[settings board_size]];
    [self setHandicap:[settings handicap]];
    [self setKomi:[settings komi]];
    
    [self setPlayer1:[[Player alloc] init]];
    [self setPlayer2:[[Player alloc] init]];
    [[self player1] setColor:BLACK];
    [[self player2] setColor:WHITE];
    [[self player1] setNext:[self player2]];
    [[self player1] setNext:[self player1]];
    
    return self;
}

@end
