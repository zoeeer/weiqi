//
//  MyViewController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"
#import "Settings.h"

@implementation StoneCell

//- (NSView *) newStoneCell
//{
//    //StoneCell *cell = [[StoneCell alloc] initWithNibName:@"Cell" bundle:nil];
//    StoneCell *cell = [[StoneCell alloc] initWithFrame:NSMakeRect(0, 0, <#CGFloat w#>, <#CGFloat h#>)];
//}

- (instancetype)initWithColor:(Color)color Index:(NSInteger)index Size:(CGFloat)size
{
    if (self = [super initWithFrame:NSMakeRect(0, 0, size, size)]) {
        ;
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
    NSPoint clickLocation;
    Coord clickCoord;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
                              fromView:nil];
    clickCoord = [self convertCoordFromPoint:clickLocation];
}

- (void)addStoneOfColor:(Color)color Coord:(Coord)coord
{
    StoneCell *cell = [[StoneCell alloc] initWithFrame:NSMakeRect(0, 0, [self cellsize], [self cellsize])];
    [self addSubview:<#(NSView *)#>]
    
}

@end

@interface GameViewController ()

@end

@implementation GameViewController

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
    // Create game objects
    game = [[Game alloc] initWithSettings:asettings];
    
    NSLog(@"game view controller initWithSettings");

    return self;
}

- (void)awakeFromNib
{
    [[self boardView] setBoardsize:[[self settings] board_size]];
    [[self boardView] setCurrentColor:BLACK];
    [[self boardView] setCellsize:40];
}

@end
