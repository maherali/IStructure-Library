#import "SessionSync.h"
#import "MyErrorDecoder.h"

@implementation SessionSync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    NSString    *userName = @"alime@me.com";
    NSString    *password = @"test123 ";
    [request     setValue:$sprintf(@"Basic %@", [[$sprintf(@"%@:%@", userName, password) dataUsingEncoding:NSASCIIStringEncoding] base64Encoding]) forHTTPHeaderField:@"Authorization"];
    return request;
}

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
