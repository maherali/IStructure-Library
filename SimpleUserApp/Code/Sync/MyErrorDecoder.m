#import "MyErrorDecoder.h"

@implementation MyErrorDecoder

- (NSString*) errorMessage{
    NSDictionary *errorsHash = [self.data concreteObject];
    if([errorsHash isKindOfClass:[NSDictionary class]])
        return [errorsHash objectForKey:@"error"];
    else 
        return nil;
}

- (BOOL) hasAppLevelErrors{
    return [self errorMessage] != nil;
}

- (NSArray*) appLevelErrors{
    return $array([self errorMessage]);
}

@end
