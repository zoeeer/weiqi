//
//  AppDelegate.h
//  双人围棋
//
//  Created by Rang on 18/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MyWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet MyWindowController *windowController;

@end

