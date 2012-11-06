#import "VideoSession.h"
#import <ImageIO/ImageIO.h>

@implementation VideoSession

@synthesize captureSession;
@synthesize previewLayer;

#pragma mark Capture Session Configuration

- (id)init {

	if ((self = [super init])) {

		[self setCaptureSession:[[AVCaptureSession alloc] init]];

	}

	return self;

}

- (void)addCaptureVideoPreviewLayer {
	
	[self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]]];
	[[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	
}

- (void)addVideoInputFrontCamera:(BOOL)front {
	
    NSError *error = nil;

    NSArray *captureDevices = [AVCaptureDevice devices];

    AVCaptureDevice *cameraFront;
    AVCaptureDevice *cameraRear;
    
    for (AVCaptureDevice *captureDevice in captureDevices) {
        
        if ([captureDevice hasMediaType:AVMediaTypeVideo]) {
            
            if ([captureDevice position] == AVCaptureDevicePositionBack) {

                cameraRear = captureDevice;

            } else {

                cameraFront = captureDevice;

            }

        }
    
	}
    
    
    if (front) {

        AVCaptureDeviceInput *captureDeviceInputFrontFacing = [AVCaptureDeviceInput deviceInputWithDevice:cameraFront error:&error];

        if (!error) {

            if ([[self captureSession] canAddInput:captureDeviceInputFrontFacing]) {

                [[self captureSession] addInput:captureDeviceInputFrontFacing];

            } else {

                NSLog(@"Error adding front facing video");

            }

        }

    } else {

        AVCaptureDeviceInput *captureDeviceInputRearFacing = [AVCaptureDeviceInput deviceInputWithDevice:cameraRear error:&error];

        if (!error) {

            if ([[self captureSession] canAddInput:captureDeviceInputRearFacing]) {

                [[self captureSession] addInput:captureDeviceInputRearFacing];

            } else {
				
                NSLog(@"Error adding rear facing video");

            }

        }

    }

}

- (void)dealloc {
	
	[[self captureSession] stopRunning];
	
	previewLayer = nil;
	captureSession = nil;

}

@end
