#import "WelcomeView.h"
#import "TCLink.h"

@implementation WelcomeView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];

    TCLink *link = [TCLink linkWithLabel:@"Welcome, now logout"];
    link.frame = CGRectMake(100, 75, 125, 20);
    [self addSubview:link]; 
    
    __block WelcomeView *this = self;
    $watch(TCLinkEventMame, link,  ^(NSNotification *notif){
        $trigger(@"logout:requested");
    });
    
    return self;
}

@end
