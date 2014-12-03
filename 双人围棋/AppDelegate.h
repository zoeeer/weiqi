//
//  AppDelegate.h
//  双人围棋
//
//  Created by Rang on 18/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//@class MyWindowController;
@class Board;
@class Settings;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    Settings *settings;
    //IBOutlet NSButton *startButton;
}

@property (weak) IBOutlet NSButton *startButton;

@property (strong, nonatomic) Settings* settings;

- (IBAction)start:(id)sender;
- (IBAction)setBoardSize:(id)sender;

@end

