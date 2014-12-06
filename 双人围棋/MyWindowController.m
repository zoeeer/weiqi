//
//  MyWindowController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "MyWindowController.h"
#import "GameViewController.h"

#import "Settings.h"

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
    [self.settings setBoard_size:19];
    NSLog(@"Default board size is %ld", [self.settings board_size]);
}

- (IBAction)start:(id)sender {
    NSLog(@"Board size is set to %ld", [self.settings board_size]);
//    if (! self.settings) {
//        NSLog(@"self.settings no longer exist!!");
//    }
    
    // initialize game view from nib file
    [self willChangeValueForKey:@"gameViewController"];
    gameViewController = [[GameViewController alloc] initWithNibName:@"Game" bundle:nil];
    [self didChangeValueForKey:@"gameViewController"];
    
    NSLog(@"Initial window size is %f, %f", [self window].frame.size.height, [self window].frame.size.width);
    NSLog(@"Initial window origin is %f, %f", [self window].frame.origin.x, [self window].frame.origin.y);
    NSLog(@"gameView size is %f, %f", [gameViewController view].frame.size.height, [gameViewController view].frame.size.width);
    
    // Switch startup view to game view
//    [myTargetView replaceSubview:startupView with:[gameViewController view]];
    [startupView removeFromSuperview];
    NSRect frame = [[self window] frame];
    NSSize contentSize = myTargetView.frame.size;
    NSSize targetSize = [gameViewController view].frame.size;
    // For simplicity in early version, only show the board
    frame.size.width += targetSize.height - contentSize.width;
    frame.size.height += targetSize.height - contentSize.height;
    frame.origin.y -= targetSize.height - contentSize.height;
    NSLog(@"modified window origin is %f, %f", frame.origin.x, frame.origin.y);
    [[self window] setFrame:frame display:YES animate:YES];
   // [[self window] setContentSize:[gameViewController view].frame.size];

    [myTargetView addSubview:[gameViewController view]];
    [[gameViewController view]  setFrame:[myTargetView bounds]];
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
