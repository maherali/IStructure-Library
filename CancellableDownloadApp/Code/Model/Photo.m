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

- (void) fetch:(NSDictionary *)options{
    [super fetch:options];
    __block Photo *this = self;
    $unwatch(@"content-length");
    $watch(@"content-length", self.sync, ^(NSNotification *notif){
        NSString *length = [notif.userInfo objectForKey:@"length"];
        LOG(@"Length is %@", length)
    });
    $watch(@"received-data-count", self.sync, ^(NSNotification *notif){
        NSString *length = [notif.userInfo objectForKey:@"length"];
        LOG(@"received so far  %@", length)
    });
    [self.sync start];
}

- (void)dealloc {
    self.image  =   nil;
    [super dealloc];
}

@end
