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

@end
