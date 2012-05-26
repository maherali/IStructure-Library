#import "Notes.h"
#import "Note.h"
#import "ISSecureCachedSync.h"

@implementation Notes

-(Class) modelClass{
    return [Note class];
}

- (NSString*) path{
    return @"/notes";
}

// Uncomment this to enable caching
+ (Class) syncClass{
    return [ISSecureCachedSync class];    
}

@end
