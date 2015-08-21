//
//  BoardView.h
//  双人围棋
//
//  Created by Rang on 21/8/15.
//  Copyright (c) 2015 Rang. All rights reserved.
//

#ifndef _____BoardView_h
#define _____BoardView_h

#import <Cocoa/Cocoa.h>
#import "Game.h"

/**********************************************
 ****              StoneCell               ****
 **********************************************/
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
- (id)addStoneOfColor:(Color)color Coord:(Coord)coord Index:(int)index;

@end


#endif
