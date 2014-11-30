//
//  AppDelegate.m
//  双人围棋
//
//  Created by Rang on 18/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "AppDelegate.h"

#import "Settings.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (strong) Settings* settings;
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //[self.window setDocumentEdited:YES];

    [self setSettings:[[Settings alloc] init]];
    [self.settings setBoard_size:19];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

// -------------------------------------------------------------------------------
//	applicationShouldTerminateAfterLastWindowClosed:sender
//
//	NSApplication delegate method placed here so the sample conveniently quits
//	after we close the window.
// -------------------------------------------------------------------------------
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


- (IBAction)start:(id)sender {
    NSLog(@"Board size is set to %ld", [self.settings board_size]);
}

- (IBAction)setBoardSize:(id)sender {
    NSMenuItem *item = [sender selectedItem];
    NSLog(@"Size changed to %@", item);
    //NSLog(@"item title: %@", [item title]);
    //NSLog(@"item tag: %ld", [item tag]);
    [self.settings setBoard_size:[item tag]];
    NSLog(@"Board size is set to %ld", [self.settings board_size]);
}
@end
