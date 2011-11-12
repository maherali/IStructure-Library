#import "TCLoginController.h"
#import "TCLoginView.h"
#import "Session.h"

@implementation TCLoginController

- (void) login{
    __block TCLoginController *this = self;
    if(((Session*)self.model).loggedIn){
        [UIAlertView message:$array(@"You are already logged in!")];
        $navigate(@"/welcome");
        return;
    }
    $trigger(@"internet:begin", this.model);
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
         $trigger(@"internet:end", this.model);
        [UIAlertView message:$array(@"Success logging to server!")];
        ((Session*)this.model).loggedIn = YES;
        $navigate(@"/welcome");
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
         $trigger(@"internet:end", this.model);
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

- (void) logout{
    __block TCLoginController *this = self;
    
    $trigger(@"internet:begin", self.model);
    [self.model destroy:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        $trigger(@"internet:end", this.model);
        [UIAlertView message:$array(@"You have successfully logged out of server!")];
        ((Session*)this.model).loggedIn = NO;
        [this.navigationController popToRootViewControllerAnimated:NO];
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        $trigger(@"internet:end", this.model);
        [UIAlertView errors:errors];
    }))];
}

- (NSDictionary*) routes{
    __block TCLoginController *this = self;
    return $dict(@"/logout", $block(^(NSNotification* notif){
        [this logout];        
    }));    
}

@end



