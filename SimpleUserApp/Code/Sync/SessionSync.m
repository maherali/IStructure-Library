#import "SessionSync.h"

@implementation SessionSync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    [request addBasicHTTPAuthHeaderForUser:[self.options objectForKey:@"USER_NAME"] withPassword:[self.options objectForKey:@"PASSWORD"]];
    return request;
}

@end
