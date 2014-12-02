//
//  MyWindowController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MyViewController.h"

@interface MyWindowController : NSWindowController
{
    MyViewController *startupView;
    MyViewController *gameView;
    IBOutlet NSView	*myTargetView;
}

@end
