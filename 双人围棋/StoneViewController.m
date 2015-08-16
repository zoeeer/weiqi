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

- (instancetype)initWithColor:(Color)color Index:(int)index Coord:(Coord) acoord
{
    if (self = [super initWithNibName:@"Cell" bundle:nil]) {
        [self setColor:color];
        [self setIndex:index];
        [self setCoord:acoord];
        [[self view] setHidden:YES];
    }
    return self;
}

- (void)awakeFromNib
{
    //[[[self label] cell] setTitle:[NSString stringWithFormat:@"%ld", (long)[self index]]];
    [[[self label] cell] setIntValue:[self index]];
    
    // choose stone image
    switch ([self color]) {
        case BLACK:
            [[self image] setImage:[NSImage imageNamed:@"black"]];
            [[self label] setTextColor:[NSColor whiteColor]];
            break;
            
        case WHITE:
            [[self image] setImage:[NSImage imageNamed:@"white"]];
            [[self label] setTextColor:[NSColor blackColor]];
            break;
            
        default:
            break;
    };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
