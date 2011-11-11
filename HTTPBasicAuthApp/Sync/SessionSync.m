#import "SessionSync.h"
#import "MyErrorDecoder.h"

@implementation SessionSync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    NSLog(@"%@", self.options);
    NSString    *userName = [self.options objectForKey:@"USER_NAME"];
    NSString    *password = [self.options objectForKey:@"PASSWORD"];
    [request     setValue:$sprintf(@"Basic %@", [[$sprintf(@"%@:%@", userName, password) dataUsingEncoding:NSASCIIStringEncoding] base64Encoding]) forHTTPHeaderField:@"Authorization"];
    return request;
}

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
