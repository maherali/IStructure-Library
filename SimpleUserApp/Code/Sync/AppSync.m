#import "AppSync.h"
#import "MyErrorDecoder.h"

@implementation AppSync

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
