#import "Marketing.h"
#import "MarketingSync.h"

@implementation Marketing

- (NSString*) url{
    return @"/marketings/1.json";
}

+ (Class) syncClass{
    return [MarketingSync class];
}

@end
