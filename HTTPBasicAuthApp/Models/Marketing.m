#import "Marketing.h"
#import "MarketingSync.h"

@implementation Marketing

- (NSString*) path{
    return @"/marketings/1.json";
}

+ (Class) syncClass{
    return [MarketingSync class];
}

@end
