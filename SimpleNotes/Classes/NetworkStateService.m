#import "NetworkStateService.h"

static NetworkStateService  *singleton          = nil;
static int                  netActivityCounter  = 0;

@implementation NetworkStateService

@synthesize observers;

- (void) updateNetworkActivity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(netActivityCounter > 0)];
}

- (id) intWithOptions:(NSDictionary*) options{
    self = [super init];
    self.observers = $marray();
    __block NetworkStateService *this = self;
    $watch(@"network:on", ^(NSNotification* notif){
        ++netActivityCounter;
        [this updateNetworkActivity];
    });
    $watch(@"network:off", ^(NSNotification* notif){
        --netActivityCounter;
        [this updateNetworkActivity];
    });
    return self;
}

+ (void) startWithOptions:(NSDictionary*) options{
    singleton = singleton ? singleton : [[self alloc] intWithOptions:options];
}

+ (void) load{
    __block Class this = self;
    $register(@"net_state");
}

- (void) dealloc{
    __block NetworkStateService *this = self;
    $unwatch();
    [super dealloc];
}

@end
