#import "TCDateFormatter.h"

static NSString *serverDataTimeFormatString         = @"yyyy-MM-dd'T'HH:mm:ss";
static NSString *dayOfWeekWithMonthAndDay           = @"EEE MMM d";

@implementation TCDateFormatter

+ (NSDateFormatter*) serverDataTimeFormatter{
    static NSDateFormatter *formatter = nil;
	if (!formatter) {
		formatter = [NSDateFormatter new];
        [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
		[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[formatter setDateFormat:serverDataTimeFormatString];
	}
    return formatter;
}

+(NSString *)dayOfWeekWithMonthAndDay:(NSString *)yyyyMMddTHHmmss {
	static NSDateFormatter *formatter = nil;
	if (!formatter) {
		formatter = [NSDateFormatter new];
		[formatter setDateFormat:dayOfWeekWithMonthAndDay];
	}
	return [formatter stringFromDate:[[self serverDataTimeFormatter] dateFromString:yyyyMMddTHHmmss]];
}

@end
