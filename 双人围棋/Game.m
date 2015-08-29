//
//  Game.m
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "Game.h"
#import "Settings.h"

#import "StoneViewController.h"
/**********************************************
 ****                Record                ****
 **********************************************/
@interface Record ()
@property (readwrite) StoneViewController *stoneVC;
@property (readwrite) NSArray *captured;
//@property (readwrite) NSString *recString;
@property (readwrite) char *rec;
@end

@implementation Record

- (instancetype)initWithCurrentMove:(StoneViewController*)stonevc CapturedArray:(NSArray*)capturedArray
{
    if (self = [super init]) {
        [self setStoneVC:stonevc];
        [self setCaptured:capturedArray];

        _rec = NSAllocateCollectable(4, 0);
        _rec[0] = [stonevc color] == BLACK ? 'B' : 'W';
        _rec[1] = [stonevc coord].x + 'a';
        _rec[2] = [stonevc coord].y + 'a';
        _rec[3] = '\0';
    }
    return self;
}

- (NSString *)toString
{
    return [[NSString alloc] initWithCString:_rec encoding:NSUTF8StringEncoding];
}

@end
/**********************************************
 ****                Player                ****
 **********************************************/

@implementation Player

- (instancetype)initWithColor:(Color)color
{
    if (self = [super init]) {
        [self setColor:color];
        if (color != NONE && [self name] == nil) {
            [self setName:color == BLACK? @"Black" : @"White"];
        }
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

    [self setPlayer1:[[Player alloc] initWithColor:BLACK]];
    [self setPlayer2:[[Player alloc] initWithColor:WHITE]];
    [[self player1] setNext:[self player2]];
    [[self player1] setNext:[self player1]];

    return self;
}

@end
