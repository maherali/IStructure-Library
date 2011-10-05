#import "Place.h"

@implementation Place

- (NSString*) description{
    return [[self get:@"toponymName"] isEqual:[NSNull null]] ? @"" : [self get:@"toponymName"];
}

@end
