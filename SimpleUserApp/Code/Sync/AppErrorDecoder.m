#import "AppErrorDecoder.h"

@implementation AppErrorDecoder

- (NSString*) allErrorsForKey:(NSString*) key andValues:(NSArray*) arr{
    NSMutableArray *allErrors = $marray();
    if([arr isKindOfClass:[NSArray class]]){
        for(NSString *v in arr){
            [allErrors addObject:$sprintf(@"%@ %@", key, v)];
        }
        return [allErrors componentsJoinedByString:@", "];
    }else{
        return [arr description];
    }
}
- (NSString*) errorMessage{
    NSDictionary    *errorsHash    = [self.data concreteObject];
    NSMutableString *str           = [NSMutableString string];
    for(NSString *key in [errorsHash allKeys]){
        [str appendFormat:@"%@\n", [self allErrorsForKey:key andValues:[errorsHash objectForKey:key]]];
    }
    return str;
}

- (NSArray*) appLevelErrors{
    return $array([self errorMessage]);
}

@end
