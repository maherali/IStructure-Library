#import "Registration.h"
#import "AppSync.h"

@implementation Registration

- (NSString*) createPath{
    return @"/users.json";
}

+ (Class) syncClass{
    return [AppSync class];
}

- (NSData*) dataToSave{
    NSMutableDictionary *user = $mdict();
    NSMutableDictionary *attrs = $mdict(@"user", user);
    [user setObject:[self get:@"email"] forKey:@"email"];
    [user setObject:[self get:@"password"] forKey:@"password"];
    [user setObject:[self get:@"password_confirmation"] forKey:@"password_confirmation"];
    return [self JSONDataFromAttributes:attrs];
}

- (NSArray*) validate:(NSDictionary*) attrs{
    NSMutableArray  *arr    = $marray();
    NSString        *email  = [attrs objectForKey:@"email"];
    if(email && [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Email is missing"];
    }
    NSString        *password  = [attrs objectForKey:@"password"];
    if(password && [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Password is missing"];
    }
    NSString        *passwordConf  = [attrs objectForKey:@"password_confirmation"];
    if(passwordConf && [passwordConf stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Password confirmation is missing"];
    }
    if(password && passwordConf && ![password isEqualToString:passwordConf]){
        [arr addObject:@"Password and password confirmation do not match"];
    }
    return arr;
}

@end
