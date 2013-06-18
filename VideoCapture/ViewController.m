//
//  ViewController.m
//  VideoCapture
//
//  Created by James Border on 11/6/12.
//  Copyright (c) 2012 James Border. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain) VideoSession *videoSession;

@end

@implementation ViewController

@synthesize videoSession;

- (void)viewDidLoad {

    [super viewDidLoad];

    [self.view setFrame:[UIScreen mainScreen].bounds];

	[self setVideoSession:[[VideoSession alloc] init]];
	[[self videoSession] addVideoInputFrontCamera:YES];
	[[self videoSession] addCaptureVideoPreviewLayer];

	CGRect layerRect = [[[self view] layer] bounds];
    [[[self videoSession] previewLayer] setBounds:layerRect];
    [[[self videoSession] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self videoSession] previewLayer]];

	[[videoSession captureSession] startRunning];

}

-(void)viewDidAppear:(BOOL)animated {
    
    [self willRotateToInterfaceOrientation:[[UIDevice currentDevice]orientation] duration:1];
    [self willAnimateRotationToInterfaceOrientation:[[UIDevice currentDevice]orientation] duration:1];

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if ([[[[self videoSession] previewLayer] connection] isVideoOrientationSupported]) {
        [[[[self videoSession] previewLayer] connection] setVideoOrientation:toInterfaceOrientation];
    }

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    CGRect layerRect = [self.view bounds];
    [[[self videoSession] previewLayer] setBounds:layerRect];
    [[[self videoSession] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                 CGRectGetMidY(layerRect))];
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration: duration];

}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
