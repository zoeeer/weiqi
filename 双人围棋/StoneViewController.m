//
//  StoneViewController.m
//  双人围棋
//
//  Created by Rang on 17/12/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "StoneViewController.h"

//static NSImage *blackImg;
//static NSImage *whiteImg;

@interface StoneViewController ()

@end

@implementation StoneViewController

- (instancetype)initWithColor:(Color)color Index:(NSInteger)index
{
    if (self = [super initWithNibName:@"Cell" bundle:nil]) {
        
        [[[self label] cell] setTitle:[NSString stringWithFormat:@"%ld", (long)index]];
        
        // choose stone image
        switch (color) {
            case BLACK:
                [[self image] setImage:[[NSImage alloc] initByReferencingFile:@"black"]];
                [[self label] setTextColor:[NSColor whiteColor]];
                break;
                
            case WHITE:
                [[self image] setImage:[[NSImage alloc] initByReferencingFile:@"white"]];
                [[self label] setTextColor:[NSColor blackColor]];
                break;
                
            default:
                break;
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
