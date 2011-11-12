#import "WelcomeView.h"
#import "TCTermsAndConditionsLabel.h"

@implementation WelcomeView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    TCTermsAndConditionsLabel *tncLabel = [[[TCTermsAndConditionsLabel alloc] init] autorelease];	
    tncLabel.text = @"Welcome, now logout";
    tncLabel.frame = CGRectMake(100, 75, 125, 20);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:tncLabel]; 
    
    WelcomeView *this = self;
    $watch(@"link_tapped", tncLabel,  ^(NSNotification *notif){
        $navigate(@"/logout");
    });
    return self;
}

@end
