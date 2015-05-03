//
//  MyWindowController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "MyWindowController.h"
#import "GameController.h"

#import "Settings.h"
#import "Game.h"
//@class GameController;

@interface MyWindowController ()

@end

@implementation MyWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    //NSLog(@"windowDidLoad");
}

// -------------------------------------------------------------------------------
//	awakeFromNib:
// -------------------------------------------------------------------------------
- (void)awakeFromNib
{
    //NSLog(@"awakeFromNib");
    //[[self window] setAutorecalculatesContentBorderThickness:YES forEdge:NSMinYEdge];
    //[[self window] setContentBorderThickness:30 forEdge:NSMinYEdge];
    
    [myTargetView addSubview:startupView];
    
    // make sure we resize the viewController's view to match its super view
    [startupView setFrame:[myTargetView bounds]];
    
    [self setSettings:[[Settings alloc] init]];
    NSLog(@"Default board size is %ld", [self.settings board_size]);
}

- (IBAction)start:(id)sender {
    NSLog(@"Board size is %ld", [self.settings board_size]);
    
    // initialize game view from nib file
    [self willChangeValueForKey:@"gameController"];
    gameController = [[GameController alloc] initWithSettings:[self settings]];
    [self didChangeValueForKey:@"gameController"];
    
    NSLog(@"Initial window size is %f, %f", [self window].frame.size.height, [self window].frame.size.width);
    NSLog(@"Initial window origin is %f, %f", [self window].frame.origin.x, [self window].frame.origin.y);
    NSLog(@"gameView size is %f, %f", [gameController view].frame.size.height, [gameController view].frame.size.width);
    
    // Switch startup view to game view
//    [myTargetView replaceSubview:startupView with:[gameViewController view]];
    [startupView removeFromSuperview];
    NSRect frame = [[self window] frame];
    NSSize contentSize = myTargetView.frame.size;
    NSSize targetSize = [gameController view].frame.size;
    // For simplicity in early version, only show the board
    frame.size.width += targetSize.height - contentSize.width;
    frame.size.height += targetSize.height - contentSize.height;
    frame.origin.y -= targetSize.height - contentSize.height;
    NSLog(@"modified window origin is %f, %f", frame.origin.x, frame.origin.y);
    [[self window] setFrame:frame display:YES animate:YES];
   // [[self window] setContentSize:[gameViewController view].frame.size];

    [myTargetView addSubview:[gameController view]];
    [[gameController view]  setFrame:[myTargetView bounds]];
    
    // Start to Run Game
    [gameController run];
}

- (IBAction)setBoardSize:(id)sender {
    NSLog(@"Board size is previously %ld", [self.settings board_size]);
    NSMenuItem *item = [sender selectedItem];
    NSLog(@"Size changed to %@", item);
    //NSLog(@"item title: %@", [item title]);
    //NSLog(@"item tag: %ld", [item tag]);
    [self.settings setBoard_size:[item tag]];
    NSLog(@"Board size is set to %ld", [self.settings board_size]);
}

@end
