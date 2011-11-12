#import "SessionSync.h"
#import "MyErrorDecoder.h"

@implementation Session1Sync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    [request addBasicHTTPAuthHeaderForUser:[self.options objectForKey:@"USER_NAME"] withPassword:[self.options objectForKey:@"PASSWORD"]];
    return request;
}

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
