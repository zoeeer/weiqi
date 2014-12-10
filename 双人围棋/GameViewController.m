//
//  MyViewController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"

@implementation BoardView

-(void)mouseDown:(NSEvent *)event
{
    NSPoint clickLocation;
    BOOL itemHit=NO;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
                              fromView:nil];
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

- (instancetype)initWithSettings:(Settings *)settings
{
    if (self = [super initWithNibName:@"Game" bundle:nil]) {
        // init board view according to board size
    }
    // Create game objects
    game = [[Game alloc] initWithSettings:settings];
    NSLog(@"game view controller initWithSettings");

    return self;
}

@end
