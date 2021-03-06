//
//  Game.h
//  双人围棋
//
//  Created by Rang on 23/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Settings;
@class StoneViewController;

typedef enum {
    BLACK = 1,
    WHITE = -1,
    NONE = 0,
} Color;

typedef struct {
    int x;
    int y;
} Coord;

typedef enum {
    ManToMan,
    ManToMachine,
    MachineToMan,
    Online,
} GameMode;

typedef enum {
    INIT,
    WAIT_INPUT,
} GameState;

/**********************************************
 ****                Record                ****
 **********************************************/
@interface Record : NSObject

@property (readonly) StoneViewController *stoneVC;
@property (readonly) NSArray *captured;
- (instancetype)initWithCurrentMove:(StoneViewController*)stonevc CapturedArray:(NSArray*)capturedArray;
@end

/**********************************************
 ****                Player                ****
 **********************************************/

@interface Player : NSObject

@property (strong) NSString *name;
@property Color color;
@property (weak) Player *next;

- (instancetype)initWithColor:(Color)color;
- (GameState) move;
@end

/**********************************************
 ****          Game (deprecated)           ****
 **********************************************/

@interface Game : NSObject

@property NSInteger boardsize;
@property NSInteger handicap;
@property CGFloat komi;
@property (strong) Player *player1;
@property (strong) Player *player2;
@property (weak) Player *currentplayer;

- initWithSettings:(Settings*)settings;

@end
