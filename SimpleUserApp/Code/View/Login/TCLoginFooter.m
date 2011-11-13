#import "TCLoginFooter.h"
#import "TCUIFactory.h"
#import "TCLink.h"
#import "TCInternetButton.h"

@implementation TCLoginFooter

- (id) initWithFrame:(CGRect)frame andModel:(ISModel*) model{
    self = [super initWithFrame:frame];
    TCInternetButton *signinButton = [TCInternetButton buttonForObservable:model target:self action:@selector(signIn) frame:CGRectMake(5, 17, 310, 50) andLabel:@"Sign In"];
    TCInternetButton *signupButton = [TCInternetButton buttonForObservable:nil target:self action:@selector(signUp) frame:CGRectMake(5, 75, 310, 50) andLabel:@"Sign Up"];
    
    TCLink *tncLabel = [TCLink linkWithLabel:@"Terms & Conditions"];	
    tncLabel.frame = CGRectMake(100, 140, 125, 20);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:signinButton];
    [self addSubview:signupButton];
    [self addSubview:tncLabel]; 
    return self;
}

- (void) signIn{
    __block TCLoginFooter *this = self;
    $trigger(@"signin_button:tapped");
}

- (void) signUp{
    __block TCLoginFooter *this = self;
    $trigger(@"start_signup_button:tapped");
}

@end
