#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SpringBoard/SpringBoard.h>
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(UIWindow);

UIImage *image;
UIImageView *imageView;

CHMethod1(void, UIWindow, sendEvent, UIEvent *, event)
{
	UITouch *touch = [[event allTouches] anyObject];
	UITouchPhase phase = [touch phase];
	if (phase != UITouchPhaseEnded && phase != UITouchPhaseCancelled) {
		CGPoint location = [touch locationInView:self];
		imageView.center = location;
		[self addSubview:imageView];
	
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[imageView setAlpha:1.0];
		[UIView commitAnimations];
	} else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[imageView setAlpha:0.0];
		[UIView commitAnimations];	
	}
	
	CHSuper1(UIWindow, sendEvent, event);
}

CHConstructor
{
	CHAutoreleasePoolForScope();
	
	image = [UIImage imageWithContentsOfFile:@"/Library/ProTapper/dot.png"];
	imageView = [[UIImageView alloc] initWithImage:image];
	[imageView setAlpha:1.0];
	
	CHLoadLateClass(UIWindow);
	CHHook1(UIWindow, sendEvent);
}
