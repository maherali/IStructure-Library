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

@end
