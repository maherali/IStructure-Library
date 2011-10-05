#import "GeoNamesSync.h"
#import "GeoNamesErrorDecoder.h"

@implementation GeoNamesSync

+ (Class) errorDecoderClass{
    return [GeoNamesErrorDecoder class];
}

@end
