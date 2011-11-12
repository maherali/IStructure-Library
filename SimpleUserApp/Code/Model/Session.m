#import "Session.h"
#import "SessionSync.h"

@implementation Session

@synthesize loggedIn;

- (NSString*) createPath{
    return @"/users/sign_in.json";
}

- (NSString*) destroyPath{
    return @"/users/sign_out.json";
}

+ (Class) syncClass{
    return [SessionSync class];
}

- (void) lastChanceToUpdateSyncOptions:(NSMutableDictionary*) opts forMethod:(NSString*) method{
    [opts setObject:[self get:@"user_name"] forKey:@"USER_NAME"];
    [opts setObject:[self get:@"password"] forKey:@"PASSWORD"];
}

@end
