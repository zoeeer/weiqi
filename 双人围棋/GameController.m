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
    [[self board] setAllowClick: NO];
    [[self board] setGameDelegate: self];
}

- (void)run
{
    if ([[self currentplayer] move] == WAIT_INPUT) {
        [[self board] setAllowClick: YES];
    }
}

- (BOOL)isValidCoord:(Coord)aCoord
{
    if (aCoord.x < 0 || aCoord.x >= boardsize || aCoord.y < 0 || aCoord.y >= boardsize) {
        return NO;
    }
    return YES;
}

- (BOOL)isOccupied:(Coord)aCoord
{
    // return Invalid if position already occupied
    if (boardstate[aCoord.x][aCoord.y] != nil) {
        return YES;
    }
    return NO;
}

- (NSArray *)getCapturedAt:(Coord)aCoord
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
    if ([self getCapturedAt:coord] != nil) {
        return YES;
    }
    return NO;
}

- (NSArray *)getCapturedAround:(Coord)aCoord
{
    int x = aCoord.x;
    int y = aCoord.y;
    Color oppoColor = -boardstate[x][y].color;
    NSMutableArray *capturedArray = [[NSMutableArray alloc] init];
    // left
    if (x > 0 && [boardstate[x-1][y] color] == oppoColor) {
        [capturedArray addObjectsFromArray: [self getCapturedAt:(Coord) {x-1, y}]];
    }
    // right
    if (x < boardsize-1 && [boardstate[x+1][y] color] == oppoColor) {
        [capturedArray addObjectsFromArray: [self getCapturedAt:(Coord) {x+1, y}]];
    }
    // above
    if (y > 0 && [boardstate[x][y-1] color] == oppoColor) {
        [capturedArray addObjectsFromArray: [self getCapturedAt:(Coord) {x, y-1}]];
    }
    // below
    if (y < boardsize-1 && [boardstate[x][y+1] color] == oppoColor) {
        [capturedArray addObjectsFromArray: [self getCapturedAt:(Coord) {x, y+1}]];
    }
    
    if ([capturedArray count] > 0) {
        return capturedArray;
    }
    else {
        return nil;
    }
}

- (void) removeStones:(NSArray*)stoneArray {
    for (id stone in stoneArray) {
        boardstate[[stone coord].x][[stone coord].y] = nil;
        [[stone view] removeFromSuperview];
    }
}

- (void) addStones:(NSArray*)stoneArray {
    for (id stone in stoneArray) {
        boardstate[[stone coord].x][[stone coord].y] = stone;
        [[self board] addSubview:[stone view]];
    }
}

- (void)boardClickedAt:(Coord)aCoord
{
    NSLog(@"Clicked: x = %d, y = %d", aCoord.x, aCoord.y);
    if (! [self isOccupied:aCoord]) {
        ++self.moveCount;
        //boardstate[aCoord.x][aCoord.y] = [[self currentplayer] color];
        StoneViewController *newStone = [[self board] addStoneOfColor:[[self currentplayer] color] Coord:aCoord Index:[self moveCount]];
        boardstate[aCoord.x][aCoord.y] = newStone;
        NSArray *capturedStones = [self getCapturedAround:aCoord];
        if (capturedStones == nil && [self isCaptured:aCoord]) {
            // suicide move is invalid
            boardstate[aCoord.x][aCoord.y] = nil;
            --self.moveCount;
            return;
        }
        // do the following for a valid move
        [[newStone view] setHidden:NO];
        Record *newRec = [[Record alloc] initWithCurrentMove:newStone CapturedArray:capturedStones];
        [self removeStones:capturedStones];
        [[self moveHistory] addObject:newRec];
        [self setCurrentplayer:[[self currentplayer] next]];
        [[self board] setAllowClick: NO];
        [self run];
    }
}

- (void)toggleShowHistory:(BOOL)showHistory
{
    for (id move in [self moveHistory]) {
        StoneViewController *stone = [move stoneVC];
        [[stone label] setHidden:!showHistory];
    }
}

- (int)takeBackMoveFor:(Player*)player
{
    int countTakeBack = 0;
    Record *lastRec = [[self moveHistory] lastObject];
    if (lastRec == nil) return countTakeBack;
    NSLog(@"The move to be taken back is: %d", [[lastRec stoneVC] index]);
    
    // restore captured stones, if any
    [self addStones:[lastRec captured]];
    
    StoneViewController *stone = [lastRec stoneVC];
    // remove from board view
    [[stone view] removeFromSuperview];
    // remove from board state
    boardstate[[stone coord].x][[stone coord].y] = nil;
    // remove from history
    [[self moveHistory] removeLastObject];
    
    self.moveCount -= 1;
    countTakeBack = 1;

    if ([stone color] != [player color]) {
        countTakeBack += [self takeBackMoveFor:player];
    }
    return countTakeBack;
    
}

@end
