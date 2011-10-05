#import "PhotoErrorDecoder.h"

@implementation PhotoErrorDecoder

- (BOOL) hasAppLevelErrors{
    NSString *str = [[[NSString alloc] initWithData:self.data encoding:NSStringEncodingConversionAllowLossy] autorelease];
    return ![str isEqualToString:@"OK"];
}

- (NSArray*) appLevelErrors{
    return $array([[[NSString alloc] initWithData:self.data encoding:NSStringEncodingConversionAllowLossy] autorelease]);
}

@end
