//
//  StoneViewController.h
//  双人围棋
//
//  Created by Rang on 17/12/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Game.h"

@interface StoneViewController : NSViewController
@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSTextField *label;

@property int index;
@property Color color;
@property Coord coord;

//- (instancetype)initWithColor:(Color)color Index:(int)index;
- (instancetype)initWithColor:(Color)color Index:(int)index Coord:(Coord) acoord;
- (void)setSize:(CGFloat)size Position:(NSPoint)point;
@end
