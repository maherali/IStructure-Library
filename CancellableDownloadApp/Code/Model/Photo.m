#import "Photo.h"
#import "PhotoSync.h"

@implementation Photo

@synthesize image;

- (NSString*) path{
    return @"rc.jpg";
}

+ (Class) syncClass{
    return [PhotoSync class];
}

- (NSMutableDictionary*) parse:(NSData*) data{
    self.image = [[[UIImage alloc] initWithData:data] autorelease];
    return $mdict();
}

- (void)dealloc {
    self.image  =   nil;
    [super dealloc];
}

@end
