//
//  BoardView.m
//  双人围棋
//
//  Created by Rang on 21/8/15.
//  Copyright (c) 2015 Rang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardView.h"
#import "Game.h"
#import "GameController.h"
#import "StoneViewController.h"

@implementation StoneCell

- (instancetype)initWithColor:(Color)color Index:(NSInteger)index Size:(CGFloat)size
{
    if (self = [super initWithFrame:NSMakeRect(0, 0, size, size)]) {
        
        // create the image view
        NSImageView *image = [[NSImageView alloc] initWithFrame:[self bounds]];
        
        // create the index label
        NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(4, 10, 32, 20)];
        [label setEditable:NO];
        //[[label cell] setTitle:[NSString stringWithFormat:@"%ld", (long)index]];
        [[label cell] setTitle:@"1"];
        
        // choose stone image
        switch (color) {
            case BLACK:
                [image setCell:[[NSCell alloc] initImageCell:[[NSImage alloc] initByReferencingFile:@"black"]]];
                [label setTextColor:[NSColor whiteColor]];
                break;
                
            case WHITE:
                [image setCell:[[NSCell alloc] initImageCell:[[NSImage alloc] initByReferencingFile:@"black"]]];
                [label setTextColor:[NSColor whiteColor]];
                [label setTextColor:[NSColor blackColor]];
                break;
                
            default:
                break;
        };
        
        [self addSubview:image];
        //[self addSubview:label];
    }
    return self;
}

@end

@implementation BoardView

- (Coord)convertCoordFromPoint:(NSPoint)aPoint
{
    Coord coord;
    
    coord.x = aPoint.x / [self frame].size.width * [self boardsize];
    coord.y = aPoint.y / [self frame].size.height * [self boardsize] ;
    return coord;
}

- (NSPoint)convertCoordToPoint:(Coord)aCoord
{
    NSPoint point;
    
    point.x = aCoord.x * [self frame].size.width / [self boardsize];
    point.y = aCoord.y * [self frame].size.height / [self boardsize] ;
    return point;
}

-(void)mouseDown:(NSEvent *)event
{
    if (![self allowClick]) {
        return;
    }
    NSPoint clickLocation;
    Coord clickCoord;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
                              fromView:nil];
    clickCoord = [self convertCoordFromPoint:clickLocation];
    [[self gameDelegate] boardClickedAt:clickCoord];
    //    [self addStoneOfColor:[self currentColor] Coord:clickCoord];
}

- (void)addStoneOfColor:(Color)color Coord:(Coord)coord
{
    StoneViewController *stoneVC = [[StoneViewController alloc] initWithColor:color Index:1 Coord:coord];
    NSView *cell = [stoneVC view];
    NSRect frame = [cell frame];
    NSPoint point = [self convertCoordToPoint:coord];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    [self addSubview:cell];
}

- (id)addStoneOfColor:(Color)color Coord:(Coord)coord Index:(int)index
{
    NSString *nibName = [self boardsize] > 15 ? @"Cell_small" : @"Cell";
    StoneViewController *stoneVC = [[StoneViewController alloc] initWithNibName:nibName Color:color Index:index Coord:coord];
    NSPoint point = [self convertCoordToPoint:coord];
    [stoneVC setSize:[self cellsize] Position:point];
    [self addSubview:[stoneVC view]];
    return stoneVC;
}

@end
