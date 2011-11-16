#import "Photo.h"
#import "PhotoSync.h"

@implementation Photo

- (NSString*) path{
    return @"rc.jpg";
}

+ (Class) syncClass{
    return [PhotoSync class];
}

@end
