//
//  MyViewController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Game.h"

@class Game;
@class Settings;

@interface StoneCell : NSBox
@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSTextField *seqnum;

-(void)mouseDown:(NSEvent *)event;
@end


@interface BoardView : NSImageView

@property NSInteger boardsize;
- (Coord)convertCoordFromPoint:(NSPoint)aPoint;

@end

@interface GameViewController : NSViewController
{
    BOOL isHumanGo;
    Game *game;
}
@property (weak) Settings *settings;
@property (weak) IBOutlet BoardView *boardView;

- (instancetype)initWithSettings:(Settings *)settings;

@end
