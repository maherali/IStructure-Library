#import "Notes.h"
#import "Note.h"

@implementation Notes

-(Class) modelClass{
    return [Note class];
}

- (NSString*) url{
    return @"/notes";
}

/* Uncomment this to enable caching
+ (Class) syncClass{
    return [ISEnhancedSync class];    
}
*/


@end
