#import "SessionSync.h"

@implementation SessionSync

// To create a session (login), the client needs to send the Authorization (Basic Http authentication).
- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    [request addBasicHTTPAuthHeaderForUser:[self.options objectForKey:@"USER_NAME"] withPassword:[self.options objectForKey:@"PASSWORD"]];
    return request;
}

@end
