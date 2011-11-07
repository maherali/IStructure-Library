#import "Note.h"

@implementation Note

- (NSString*) description{
    return [[self get:@"title"] isEqual:[NSNull null]] ? @"" : [self get:@"title"];
}

- (NSString*) lastUpdated{
    return [NSDate dayOfWeekWithMonthAndDayAndTimeFromString:[self get:@"updated_at"]];
}

- (NSData*) dataToSave{
    NSMutableDictionary *attrs = [[self.attributes mutableDeepCopy] autorelease];
    [attrs removeObjectForKey:@"created_at"];
    [attrs removeObjectForKey:@"updated_at"];
    return [self JSONDataFromAttributes:attrs];
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
