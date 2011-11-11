#import "Session.h"
#import "SessionSync.h"

@implementation Session

- (NSString*) createUrl{
    return @"/users/sign_in.json";
}

+ (Class) syncClass{
    return [SessionSync class];
}

- (NSData*) dataToSave{
    return [NSData data];
}

- (void) lastChanceToUpdateSyncOptions:(NSMutableDictionary*) opts forMethod:(NSString*) method{
    [opts setObject:[self get:@"user_name"] forKey:@"USER_NAME"];
    [opts setObject:[self get:@"password"] forKey:@"PASSWORD"];
}

@end
