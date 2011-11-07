#import "GeoNamesErrorDecoder.h"

@implementation GeoNamesErrorDecoder

- (BOOL) hasAppLevelErrors{
    NSDictionary *errorsHash = [self.data concreteObject];
    return [errorsHash objectForKey:@"status"] != nil;
}

- (NSArray*) appLevelErrors{
    NSDictionary *errorsHash = [[self.data concreteObject] objectForKey:@"status"];
    NSString *message = [errorsHash objectForKey:@"message"];
    return $array(message ? message : @"Error");
}

@end
