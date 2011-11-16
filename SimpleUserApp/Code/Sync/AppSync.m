#import "AppSync.h"
#import "AppErrorDecoder.h"

@implementation AppSync

+ (Class) errorDecoderClass{
    return [AppErrorDecoder class];
}

- (BOOL) showsLoading{
    return YES;    
}

- (NSString*) loadingMessage{
    NSString    *method     = [self.options objectForKey:METHOD_KEY];
	if ([method isEqualToString:METHOD_CREATE]) {
        return @"Signing in...";
	} else if ([method isEqualToString:METHOD_DELETE]) {
        return @"Signing out...";
    }			
    return nil;
}

@end
