#import "MarketingSync.h"
#import "MyErrorDecoder.h"

@implementation MarketingSync

+ (Class) errorDecoderClass{
    return [MyErrorDecoder class];
}

@end
