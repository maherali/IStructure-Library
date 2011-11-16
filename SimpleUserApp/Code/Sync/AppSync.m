#import "AppSync.h"
#import "AppErrorDecoder.h"

@implementation AppSync

+ (Class) errorDecoderClass{
    return [AppErrorDecoder class];
}

- (BOOL) showsLoading{
    return YES;    
}

@end
