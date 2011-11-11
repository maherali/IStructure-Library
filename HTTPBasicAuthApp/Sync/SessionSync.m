#import "SessionSync.h"
#import "MyErrorDecoder.h"

@implementation SessionSync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    [request setValue:$sprintf(@"Basic %@", [[$sprintf(@"%@:%@", [self.options objectForKey:@"USER_NAME"], [self.options objectForKey:@"PASSWORD"]) dataUsingEncoding:NSASCIIStringEncoding] base64Encoding]) forHTTPHeaderField:@"Authorization"];
    return request;
}

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
