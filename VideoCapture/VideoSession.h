#import <AVFoundation/AVFoundation.h>

@interface VideoSession : NSObject {
	
}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;

- (void)addCaptureVideoPreviewLayer;
- (void)addVideoInputFrontCamera:(BOOL)front;

@end
