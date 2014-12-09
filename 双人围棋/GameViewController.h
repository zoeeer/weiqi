//
//  MyViewController.h
//  双人围棋
//
//  Created by Rang on 30/11/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StoneCell : NSBox
@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSTextField *seqnum;

@end

@interface GameViewController : NSViewController

@end
