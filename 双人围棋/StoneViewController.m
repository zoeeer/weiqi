//
//  StoneViewController.m
//  双人围棋
//
//  Created by Rang on 17/12/14.
//  Copyright (c) 2014 Rang. All rights reserved.
//

#import "StoneViewController.h"
#import "Settings.h"

//static NSImage *blackImg;
//static NSImage *whiteImg;

@interface StoneViewController ()

@end

@implementation StoneViewController

- (instancetype)initWithNibName:(NSString*)nibName Color:(Color)color Index:(int)index Coord:(Coord) acoord
{
    if (self = [super initWithNibName:nibName bundle:nil]) {
        [self setColor:color];
        [self setIndex:index];
        [self setCoord:acoord];
        [[self view] setHidden:YES];
    }
    return self;    
}

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
    [[[self label] cell] setIntValue:[self index]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showIndex = [defaults boolForKey:Key_ShowHistory];
    [[self label] setHidden:!showIndex];

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

- (void)setSize:(CGFloat)size Position:(NSPoint)point
{
    NSView *cell = [self view];
    NSRect frame = [cell frame];
    frame.size.width = size;
    frame.size.height = size;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [cell setFrame:frame];
    //[[self image] setFrameSize:frame.size];
    //[[[self image] image] setSize:frame.size];
}

@end
