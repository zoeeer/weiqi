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
    StoneViewController *stoneVC = [[StoneViewController alloc] initWithColor:color Index:index Coord:coord];
    NSView *cell = [stoneVC view];
    NSRect frame = [cell frame];
    NSPoint point = [self convertCoordToPoint:coord];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    [self addSubview:cell];
    return stoneVC;
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
    //[self setBoardsize:[asettings board_size]];
    boardsize = [asettings board_size];
    
    [self setPlayer1:[[Player alloc] initWithColor:BLACK]];
    [self setPlayer2:[[Player alloc] initWithColor:WHITE]];
    [[self player1] setNext:[self player2]];
    [[self player2] setNext:[self player1]];
    [self setCurrentplayer: [self player1]];
    
    [self setMoveCount: 0];
    [self setGameState: INIT];
    
    [self setMoveHistory: [[NSMutableArray alloc] init]];
    for (int i = 0; i < boardsize; ++i) {
        for (int j = 0; j < boardsize; ++j) {
            //boardstate[i][j] = NONE;
            boardstate[i][j] = nil;
        }
    }
    
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

- (BOOL)isValidCoord:(Coord)aCoord
{
    if (aCoord.x < 0 || aCoord.x >= boardsize || aCoord.y < 0 || aCoord.y >= boardsize) {
        return false;
    }
    return true;
}

- (BOOL)isValidMove:(Coord)aCoord
{
    // return Invalid if position already occupied
    if (boardstate[aCoord.x][aCoord.y] != nil) {
        return false;
    }
    // return Invalid if it's a suicide move
/*    else if ([[self handleCaptureAt:aCoord] count] > 0) {
        return false;
    }*/
    return true;
}

- (NSArray *)handleCaptureAt:(Coord)aCoord
{
    /* using BFS to scan this area */
    int visited[boardsize][boardsize];
    // the following queue contains all visited stones. if captured, they are exactly the ones.
    NSMutableArray *queue = [[NSMutableArray alloc] initWithObjects:boardstate[aCoord.x][aCoord.y], nil];
    memset(visited, 0, sizeof(int)*boardsize*boardsize);
    for (int index = 0; index < [queue count]; ++index) {
        StoneViewController *stone = [queue objectAtIndex:index];
        Coord curCoord = [stone coord];
        int x = curCoord.x;
        int y = curCoord.y;
        visited[x][y] = 1;
        // x - 1
        if (x > 0 && !visited[x-1][y]) {
            StoneViewController *nextStone = boardstate[x-1][y];
            if (nextStone == nil) {
                return nil;
            }
            else if (nextStone.color == stone.color) {
                [queue addObject:nextStone];
            }
        }
        // x + 1
        if (x < boardsize-1 && !visited[x+1][y]) {
            StoneViewController *nextStone = boardstate[x+1][y];
            if (nextStone == nil) {
                return nil;
            }
            else if (nextStone.color == stone.color) {
                [queue addObject:nextStone];
            }
        }
        // y - 1
        if (y > 0 && !visited[x][y-1]) {
            StoneViewController *nextStone = boardstate[x][y-1];
            if (nextStone == nil) {
                return nil;
            }
            else if (nextStone.color == stone.color) {
                [queue addObject:nextStone];
            }
        }
        // y + 1
        if (y < boardsize-1 && !visited[x][y+1]) {
            StoneViewController *nextStone = boardstate[x][y+1];
            if (nextStone == nil) {
                return nil;
            }
            else if (nextStone.color == stone.color) {
                [queue addObject:nextStone];
            }
        }
    }
    return queue;
}

- (BOOL)isCaptured:(Coord)coord
{
    if ([[self handleCaptureAt:coord] count] > 0) {
        return true;
    }
    return false;
}

- (NSArray *)handleCaptureAround:(Coord)aCoord
{
    int x = aCoord.x;
    int y = aCoord.y;
    NSMutableArray *capturedArray = [[NSMutableArray alloc] init];
    // left
    if (x > 0) {
        [capturedArray addObjectsFromArray: [self handleCaptureAt:(Coord) {x-1, y}]];
    }
    // right
    if (x < boardsize-1) {
        [capturedArray addObjectsFromArray: [self handleCaptureAt:(Coord) {x+1, y}]];
    }
    // above
    if (y > 0) {
        [capturedArray addObjectsFromArray: [self handleCaptureAt:(Coord) {x, y-1}]];
    }
    // below
    if (y < boardsize-1) {
        [capturedArray addObjectsFromArray: [self handleCaptureAt:(Coord) {x, y+1}]];
    }
    
    if (capturedArray != nil) {
        [self removeStones:capturedArray];
    }
    return capturedArray;
}

- (void) removeStones:(NSArray*)stoneArray {
    for (id stone in stoneArray) {
        boardstate[[stone coord].x][[stone coord].y] = nil;
        [[stone view] removeFromSuperview];
    }
}

- (void)boardClickedAt:(Coord)aCoord
{
    NSLog(@"Clicked: x = %d, y = %d", aCoord.x, aCoord.y);
    if ([self isValidMove:aCoord]) {
        ++self.moveCount;
        //boardstate[aCoord.x][aCoord.y] = [[self currentplayer] color];
        StoneViewController *newStone = [[self board] addStoneOfColor:[[self currentplayer] color] Coord:aCoord Index:[self moveCount]];
        boardstate[aCoord.x][aCoord.y] = newStone;
        if ([self isCaptured:aCoord]) {
            boardstate[aCoord.x][aCoord.y] = nil;
            --self.moveCount;
            return;
        }
        [[newStone view] setHidden:NO];
        [[self moveHistory] addObject:newStone];
        [self handleCaptureAround:aCoord];
        [self setCurrentplayer:[[self currentplayer] next]];
        [[self board] setAllowClick: false];
        [self run];
    }
}
@end
