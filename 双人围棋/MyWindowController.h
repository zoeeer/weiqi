//
//  MyWindowController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MyViewController.h"

@class Board;
@class Settings;

@interface MyWindowController : NSWindowController
{
    //    NSViewController *startupView;
    //    MyViewController *gameView;
    __weak IBOutlet NSView *startupView;
    __weak IBOutlet NSView	*myTargetView;
}

@property (strong, nonatomic) Settings* settings;

- (IBAction)start:(id)sender;
- (IBAction)setBoardSize:(id)sender;

@end
