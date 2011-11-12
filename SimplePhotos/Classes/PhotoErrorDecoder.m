#import "PhotoErrorDecoder.h"

@implementation PhotoErrorDecoder

- (BOOL) hasAppLevelErrors{
    NSString *str = [[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding] autorelease];
    return ![str isEqualToString:@"OK"];
}

- (NSArray*) appLevelErrors{
    return $array([[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding] autorelease]);
}

@end
