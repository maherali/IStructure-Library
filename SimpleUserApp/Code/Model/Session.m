#import "Session.h"
#import "SessionSync.h"

@implementation Session

@synthesize loggedIn, rememberMe;

- (NSString*) path{
    return @"/users/sign_in.json";
}

- (NSString*) destroyPath{
    return @"/users/sign_out.json";
}

+ (Class) syncClass{
    return [SessionSync class];
}

- (void) lastChanceToUpdateSyncOptions:(NSMutableDictionary*) opts forMethod:(NSString*) method{
    if([method isEqualToString:METHOD_CREATE]){
        [opts setObject:[self get:@"user_name"] forKey:@"USER_NAME"];
        [opts setObject:[self get:@"password"] forKey:@"PASSWORD"];
    }
}

- (BOOL) isNew{
    return !loggedIn;
}

- (NSArray*) validate:(NSDictionary*) attrs{
    NSMutableArray  *arr    = $marray();
    NSString        *userName  = [attrs objectForKey:@"user_name"];
    if(userName && [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Username is missing"];
    }
    NSString        *password  = [attrs objectForKey:@"password"];
    if(password && [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Password is missing"];
    }
    return arr;
}


@end
