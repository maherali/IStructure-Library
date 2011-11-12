#import "TCLoginController.h"
#import "TCLoginView.h"
#import "Session.h"

@implementation TCLoginController

- (void) login{
    if(((Session*)self.model).loggedIn){
        [UIAlertView message:$array(@"You are already logged in!")];
        return;
    }
     __block TCLoginController *this = self;
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        [UIAlertView message:$array(@"Success logging to server!")];
        ((Session*)this.model).loggedIn = YES;
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        [UIAlertView errors:errors];
        
    }))];
}

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    self.model = [[[Session alloc] initWithAttributes:$dict(@"user_name", @"alime@me.com", @"password", @"test123") andOptions:$dict()] autorelease];
    return self;
}

- (Class) formTableClass{
    return [TCLoginView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    __block TCLoginController *this = self;
    $unwatch(@"initiate:login", this.tableView);
    $watch(@"initiate:login", this.tableView,  ^(NSNotification *notif){
        [this login];
    });
}

@end



