//
//  MyViewController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Game.h"
#import "BoardView.h"

@class Player;
@class Settings;
@class StoneViewController;
@class Record;

/**********************************************
 ****            GameController            ****
 **********************************************/
@interface GameController : NSViewController
{
    NSInteger boardsize;
    //Color boardstate[19][19];
    StoneViewController *boardstate[19][19];
}
@property (strong) Player *player1;
@property (strong) Player *player2;
@property (weak) Player *currentplayer;
@property (weak) Settings *settings;
@property (weak) IBOutlet BoardView *board;
@property GameState gameState;
@property (strong) NSMutableArray *moveHistory;
@property int moveCount;
//@property NSMutableArray history;

- (instancetype)initWithSettings:(Settings *)settings;
- (void)run;

// Game Judgements
- (BOOL)isValidCoord:(Coord)aCoord;
- (BOOL)isOccupied:(Coord)aCoord;
- (NSArray *)getCapturedAt:(Coord)aCoord;
- (NSArray *)getCapturedAround:(Coord)aCoord;
- (BOOL)isCaptured:(Coord)coord;
- (void) removeStones:(NSArray*)stoneArray;

- (void)boardClickedAt:(Coord)aCoord;

- (void)toggleShowHistory:(BOOL)showHistory;
@end
