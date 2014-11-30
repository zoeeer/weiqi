//
//  MyWindowController.m
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "MyWindowController.h"

@interface MyWindowController ()

@end

@implementation MyWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

// -------------------------------------------------------------------------------
//	awakeFromNib:
// -------------------------------------------------------------------------------
- (void)awakeFromNib:(NSString*)nibName
{
    //[[self window] setAutorecalculatesContentBorderThickness:YES forEdge:NSMinYEdge];
    //[[self window] setContentBorderThickness:30 forEdge:NSMinYEdge];
    
    // load our nib that contains the collection view
    [self willChangeValueForKey:@"viewController"];
    viewController = [[MyViewController alloc] initWithNibName:nibName bundle:nil];
    [self didChangeValueForKey:@"viewController"];
    
    [myTargetView addSubview:[viewController view]];
    
    // make sure we resize the viewController's view to match its super view
    [[viewController view] setFrame:[myTargetView bounds]];
    
    [viewController setSortingMode:0];		// ascending sort order
    [viewController setAlternateColors:NO];	// no alternate background colors (initially use gradient background)
}

@end
