#import "RefreshButton.h"

@implementation RefreshButton 

@synthesize observers;

- (id) initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action collection:(ISCollection*) collection{
    self = [super initWithBarButtonSystemItem:systemItem target:target action:action];
    self.observers = $marray();
    __block RefreshButton *this = self;
    $watch(@"fetching:begin", collection, ^(NSNotification *notif){
        [this setEnabled:NO];
    });
    $watch(@"fetching:end", collection, ^(NSNotification *notif){
        [this setEnabled:YES];
    });
    return self;
}

+ (RefreshButton*) buttonForCollection:(ISCollection*) collection target:(id) target andAction:(SEL) action{
    return [[RefreshButton alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:target action:action collection:collection];
}

- (void) dealloc{
    __block RefreshButton *this = self;
    $unwatch();
    self.observers = nil;
    [super dealloc];
}

@end
