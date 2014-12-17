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
    NSPoint clickLocation;
    Coord clickCoord;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
                              fromView:nil];
    clickCoord = [self convertCoordFromPoint:clickLocation];
    [self addStoneOfColor:[self currentColor] Coord:clickCoord];
}

- (void)addStoneOfColor:(Color)color Coord:(Coord)coord
{
    //StoneCell *cell = [[StoneCell alloc] initWithFrame:NSMakeRect(0, 0, [self cellsize], [self cellsize])];
    StoneCell *cell = [[StoneCell alloc] initWithColor:BLACK Index:1 Size:[self cellsize]];
    NSRect frame = [cell frame];
    NSPoint point = [self convertCoordToPoint:coord];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    [self addSubview:cell];
    NSLog(nil);
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
