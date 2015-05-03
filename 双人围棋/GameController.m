//
//  MyViewController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "GameController.h"
#import "Game.h"
#import "Settings.h"
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
    StoneViewController *stoneVC = [[StoneViewController alloc] initWithColor:BLACK Index:1];
    NSView *cell = [stoneVC view];
    NSRect frame = [cell frame];
    NSPoint point = [self convertCoordToPoint:coord];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    [self addSubview:cell];
}

- (void)addStoneOfColor:(Color)color Coord:(Coord)coord Index:(NSInteger)index
{
    StoneViewController *stoneVC = [[StoneViewController alloc] initWithColor:color Index:index];
    NSView *cell = [stoneVC view];
    NSRect frame = [cell frame];
    NSPoint point = [self convertCoordToPoint:coord];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    [self addSubview:cell];
}

@end

@interface GameController ()

@end

@implementation GameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    //NSLog(@"viewDidLoad");
}

- (instancetype)initWithSettings:(Settings *)asettings
{
    if (self = [super initWithNibName:@"Game" bundle:nil]) {
        // init board view according to board size
        [self setSettings:asettings];
    }
    // Init Game Properties
    [self setBoardsize:[asettings board_size]];
    
    [self setPlayer1:[[Player alloc] init]];
    [self setPlayer2:[[Player alloc] init]];
    [[self player1] setColor:BLACK];
    [[self player2] setColor:WHITE];
    [[self player1] setNext:[self player2]];
    [[self player2] setNext:[self player1]];
    [self setCurrentplayer: [self player1]];
    
    [self setMoveCount: 0];
    [self setGameState: INIT];
    
    NSLog(@"game view controller initWithSettings");

    return self;
}

- (void)awakeFromNib
{
    [[self board] setBoardsize:[[self settings] board_size]];
    //[[self board] setCurrentColor:BLACK];
    [[self board] setCellsize:40];
    [[self board] setAllowClick: false];
    [[self board] setGameDelegate: self];
}

- (void)run
{
    if ([[self currentplayer] move] == WAIT_INPUT) {
        [[self board] setAllowClick: true];
    }
}

- (BOOL)isValidMove:(Coord)aCoord
{
    return true;
}

- (void)boardClickedAt:(Coord)aCoord
{
    if ([self isValidMove:aCoord]) {
        ++self.moveCount;
        [[self board] addStoneOfColor:[[self currentplayer] color] Coord:aCoord Index:[self moveCount]];
        [self setCurrentplayer:[[self currentplayer] next]];
        [[self board] setAllowClick: false];
        [self run];
    }
}
@end
