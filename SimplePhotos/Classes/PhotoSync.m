#import "PhotoSync.h"
#import "PhotoErrorDecoder.h"

@implementation PhotoSync

- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request{
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    return request;
}

+ (Class) errorDecoderClass{
    return [PhotoErrorDecoder class];
}

@end
