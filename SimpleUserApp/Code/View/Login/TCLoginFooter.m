#import "TCLoginFooter.h"
#import "TCUIFactory.h"
#import "TCTermsAndConditionsLabel.h"
#import "TCInternetButton.h"

@implementation TCLoginFooter

- (id) initWithFrame:(CGRect)frame andModel:(ISModel*) model{
    self = [super initWithFrame:frame];
    TCInternetButton *signinButton = [TCInternetButton buttonForObservable:model target:self action:@selector(signIn) frame:CGRectMake(5, 7, 310, 50) andLabel:@"Sign In"];
    TCTermsAndConditionsLabel *tncLabel = [[[TCTermsAndConditionsLabel alloc] init] autorelease];	
    tncLabel.frame = CGRectMake(100, 75, 125, 20);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:signinButton];
    [self addSubview:tncLabel]; 
    return self;
}

- (void) signIn{
    __block TCLoginFooter *this = self;
    $trigger(@"signin_button:tapped");
}

@end
