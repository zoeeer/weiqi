//
//  Game.h
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Settings;

typedef enum {
    BLACK,
    WHITE,
    NONE = -1,
} Color;

@interface Player : NSObject
//{
//    NSString *name;
//    Color color;
//    Player *next;
//}
@property (strong) NSString *name;
@property Color color;
@property (weak) Player *next;

@end

@interface Game : NSObject
//{
//    NSInteger handicap;
//    NSInteger komi;
//    Player *player1;
//    Player *player2;
//    Player *currentplayer;
//}

@property NSInteger boardsize;
@property NSInteger handicap;
@property CGFloat komi;
@property (strong) Player *player1;
@property (strong) Player *player2;
@property (weak) Player *currentplayer;

- initWithSettings:(Settings*)settings;

@end
