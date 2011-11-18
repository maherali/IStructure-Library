#import "Note.h"

@implementation Note

- (NSString*) description{
    return [[self get:@"title"] isEqual:[NSNull null]] ? @"" : [self get:@"title"];
}

- (NSString*) lastUpdated{
    return [NSDate dayOfWeekWithMonthAndDayAndTimeFromString:[self get:@"updated_at"]];
}

- (NSData*) dataToSave{
    [self unSet:@"created_at"];
    [self unSet:@"updated_at"];
    return [super dataToSave];
}

- (NSArray*) validate:(NSDictionary*) attrs{
    NSString    *title = [attrs objectForKey:@"title"];
    NSMutableArray  *arr = $marray();
    if(title && [title length] < 5){
        [arr addObject:@"Title cannot be less than 5 characters"];
    }
    return arr;
}

@end
