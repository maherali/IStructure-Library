#import "MyErrorDecoder.h"

@implementation MyErrorDecoder

- (NSString*) errorMessage{
    NSDictionary *errorsHash = [self.data concreteObject];
    return [errorsHash objectForKey:@"error"];
}

- (BOOL) hasAppLevelErrors{
    return [self errorMessage] != nil;
}

- (NSArray*) appLevelErrors{
    return $array([self errorMessage]);
}
 
@end
