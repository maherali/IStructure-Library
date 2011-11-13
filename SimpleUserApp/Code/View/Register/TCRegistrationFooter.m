#import "TCRegistrationFooter.h"
#import "TCLink.h"
#import "TCUIFactory.h"
#import "TCInternetButton.h"

@implementation TCRegistrationFooter

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    TCInternetButton *signUpButton = [TCInternetButton buttonForObservable:nil target:self action:@selector(signUp) frame:CGRectMake(5, 7, 310, 50) andLabel:@"Sign Up"];
    [self addSubview:signUpButton];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 20)] autorelease];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"By registering you agree to the";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:label];    
    
    self.backgroundColor = [UIColor clearColor];
    TCLink *tncLabel = [TCLink linkWithLabel:@"Terms & Conditions"];	
    tncLabel.frame = CGRectMake((320-110)/2, 75, 110, 20);
    [self addSubview:tncLabel]; 
    
    __block TCRegistrationFooter *this = self;
    $watch(TCLinkEventMame, tncLabel,  ^(NSNotification *notif){
        $trigger(@"tnc_link:tapped");
    });
    
    return self;
}

- (void) signUp{
    __block TCRegistrationFooter *this = self;
    $trigger(@"signup_button:tapped");
}

@end
