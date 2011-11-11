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
    NSString    *userName = @"alime@me.com";
    NSString    *password = @"test123 ";
    [opts setObject:userName forKey:@"USER_NAME"];
    [opts setObject:password forKey:@"PASSWORD"];
}

@end
