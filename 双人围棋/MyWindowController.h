//
//  MyWindowController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GameController;
@class Settings;

@interface MyWindowController : NSWindowController
{
    //    NSViewController *startupView;
    GameController *gameController;
    __weak IBOutlet NSView *startupView;
    __weak IBOutlet NSView	*myTargetView;
//    IBOutlet NSView *gameView9;
//    IBOutlet NSView *gameView19;
    
}

//@property GameController *gameController;
@property (strong) Settings* settings;

- (IBAction)start:(id)sender;
- (IBAction)setBoardSize:(id)sender;

- (IBAction)toggleShowHistory:(id)sender;
- (IBAction)takeBackMove:(id)sender;
@end
