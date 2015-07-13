#import "GFStatusLevelWindow.h"

@implementation GFStatusLevelWindow

- (id)commonInitializer
{
	self.backgroundColor = [UIColor clearColor];
	self.userInteractionEnabled = NO;
	self.windowLevel = UIWindowLevelStatusBar;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	return [[super initWithFrame:frame] commonInitializer];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	return [[super initWithCoder:decoder] commonInitializer];
}

#pragma mark - Overrides

- (BOOL)canBecomeFirstResponder
{
    return NO;
}

- (BOOL)becomeFirstResponder
{
	return NO;
}

- (void)becomeKeyWindow
{
	// nop
}

- (void)makeKeyWindow
{
	// nop
}

- (void)makeKeyAndVisible
{
	// nop
}

static BOOL IsAllowedKeyWindow(UIWindow *window) {
	NSString *className = [[window class] description];
	if([className isEqual:@"_GFRecordingIndicatorWindow"])
		return NO;
	if([className isEqual:@"UITextEffectsWindow"])
		return NO;
	if([window isKindOfClass:[GFStatusLevelWindow class]])
		return NO;
	
	return YES;
}

- (UIViewController *)rootViewController
{
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	if(keyWindow == self) {
		NSAssert(NO, @"This window should never become key!");
		
		NSArray *windows = [UIApplication sharedApplication].windows;
		NSInteger index = windows.count-1;
		
		UIWindow *nextWindow = [windows objectAtIndex:index];
		while(!IsAllowedKeyWindow(nextWindow) && index >= 0) {
			nextWindow = windows[--index];
		}
		
		NSLog(@"%@ became key even though it shouldn't. Choosing this as key window instead: %@", self, nextWindow);
		[nextWindow makeKeyWindow];
		return nextWindow.rootViewController;
	}
	return keyWindow.rootViewController;
}

@end
