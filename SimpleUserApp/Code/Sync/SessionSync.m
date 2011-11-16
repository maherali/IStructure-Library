#import "SessionSync.h"

@implementation SessionSync

// To create a session (login), the client needs to send the Authorization (Basic Http authentication).
- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    [request addBasicHTTPAuthHeaderForUser:[self.options objectForKey:@"USER_NAME"] withPassword:[self.options objectForKey:@"PASSWORD"]];
    return request;
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
