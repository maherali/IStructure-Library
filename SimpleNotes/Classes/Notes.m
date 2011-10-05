#import "Notes.h"
#import "Note.h"

@implementation Notes

-(Class) modelClass{
    return [Note class];
}

- (NSString*) url{
    return @"/notes";
}

@end
