//
//  MyWindowController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Board;
@class Settings;
@class Game;

@class GameViewController;

@interface MyWindowController : NSWindowController
{
    // Model components
    Settings *settings;
    Game *game;
    
    //    NSViewController *startupView;
    GameViewController *gameViewController;
    __weak IBOutlet NSView *startupView;
    __weak IBOutlet NSView	*myTargetView;
}

@property (strong, nonatomic) Settings* settings;

- (IBAction)start:(id)sender;
- (IBAction)setBoardSize:(id)sender;

@end
