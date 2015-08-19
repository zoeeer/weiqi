//
//  AppDelegate.m
//  双人围棋
//
//  Created by Rang on 18/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
//@property (weak) IBOutlet NSWindow *window;
@end


@implementation AppDelegate

//@synthesize settings;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    //[self.window setDocumentEdited:YES];

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


@end
