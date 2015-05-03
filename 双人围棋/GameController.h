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

@interface StoneCell : NSView
//@property (weak) IBOutlet NSImageView *image;
//@property (weak) IBOutlet NSTextField *seqnum;

@end


@interface BoardView : NSImageView

@property NSInteger boardsize;
@property Color currentColor;
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

@property NSInteger boardsize;
@property (strong) Player *player1;
@property (strong) Player *player2;
@property (weak) Player *currentplayer;
@property (weak) Settings *settings;
@property (weak) IBOutlet BoardView *board;
@property GameState gameState;
@property NSInteger moveCount;

- (instancetype)initWithSettings:(Settings *)settings;
- (void)run;

- (BOOL)isValidMove:(Coord)aCoord;

- (void)boardClickedAt:(Coord)aCoord;

@end
