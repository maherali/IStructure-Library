#import "TCLoginController.h"
#import "TCLoginView.h"
#import "Session.h"

@implementation TCLoginController

- (void) login{
    if(((Session*)self.model).loggedIn){
        [UIAlertView message:$array(@"You are already logged in!")];
        return;
    }
  //  __block TCLoginController *this = self;
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        [UIAlertView message:$array(@"Success logging to server!")];
        ((Session*)self.model).loggedIn = YES;
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        [UIAlertView errors:errors];
        
    }))];
}

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    [ISModel setBaseUrl:@"http://10.211.55.4:3000/"];
    self.model = [[[Session alloc] initWithAttributes:$dict(@"user_name", @"alime@me.com", @"password", @"test123") andOptions:$dict()] autorelease];
    
    
    __block TCLoginController *this = self;
    $watch(@"initiate:login", ^(NSNotification *notif){
        [this login];
    });
    
    
    return self;
}

- (Class) formTableClass{
    return [TCLoginView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

@end



