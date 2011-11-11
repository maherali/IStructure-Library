#import "MyErrorDecoder.h"

@implementation MyErrorDecoder

- (BOOL) hasAppLevelErrors{
    NSDictionary *errorsHash = [self.data concreteObject];
    return [errorsHash objectForKey:@"error"] != nil;
}

- (NSArray*) appLevelErrors{
    NSString *errorMessage = [[self.data concreteObject] objectForKey:@"error"];
    return $array(errorMessage);
}

- (BOOL) hasNetworkLevelErrors{
    NSString *errorMessage = [[self.data concreteObject] objectForKey:@"error"];
    return !errorMessage && (self.error || [$array($object(500),$object(404),$object(403)) containsObject:$object(self.response.statusCode)]);
}
 
@end
