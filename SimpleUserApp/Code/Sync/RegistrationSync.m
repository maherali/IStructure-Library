#import "RegistrationSync.h"

@implementation RegistrationSync

- (NSString*) loadingMessage{
    NSString    *method     = [self.options objectForKey:METHOD_KEY];
	if ([method isEqualToString:METHOD_CREATE]) {
        return @"Signing up...";
	} 		
    return nil;
}

@end
