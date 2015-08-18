//
//  MyViewController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Game.h"

@class Player;
@class Settings;
@class StoneViewController;
@class Record;

@interface StoneCell : NSView
//@property (weak) IBOutlet NSImageView *image;
//@property (weak) IBOutlet NSTextField *seqnum;

@end


/**********************************************
 ****              BoardView               ****
 **********************************************/
@interface BoardView : NSImageView

@property NSInteger boardsize;
@property CGFloat cellsize;
@property NSViewController *cellController;
@property BOOL allowClick;
@property id gameDelegate;
- (Coord)convertCoordFromPoint:(NSPoint)aPoint;
- (NSPoint)convertCoordToPoint:(Coord)aCoord;

@end

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

- (BOOL)isValidCoord:(Coord)aCoord;
- (BOOL)isOccupied:(Coord)aCoord;
- (NSArray *)getCapturedAt:(Coord)aCoord;
- (NSArray *)getCapturedAround:(Coord)aCoord;
- (BOOL)isCaptured:(Coord)coord;
- (void) removeStones:(NSArray*)stoneArray;

- (void)boardClickedAt:(Coord)aCoord;

@end
