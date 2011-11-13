#import "TCLoginController.h"
#import "TCLoginView.h"
#import "Session.h"
#import "Registration.h"
#import "TCPasswordVault.h"
#import "TCSettings.h"

@implementation TCLoginController

- (void) login{
    __block TCLoginController *this = self;
    if(((Session*)self.model).loggedIn){
        [UIAlertView message:$array(@"You are already logged in!")];
        $navigate(@"/welcome");
        return;
    }
    $trigger(@"login:begin", this.model);
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        [TCPasswordVault savePassword:[this.model get:@"password"] forAccount:[this.model get:@"user_name"]];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[this.model get:@"user_name"] forKey:@"last_loggedin_user"];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[this.model get:@"last_login_remember_me"] forKey:@"last_login_remember_me"];
        $trigger(@"login:end", this.model);
        [UIAlertView message:$array(@"Success logging to server!")];
        ((Session*)this.model).loggedIn = YES;
        $navigate(@"/welcome");
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        $trigger(@"login:end", this.model);
        [UIAlertView errors:errors];
    }))];
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

- (void) startRegister{
    __block TCLoginController *this = self;
    Registration *reg = [[[Registration alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    $navigate(@"/register", $dict(MODEL_KEY, reg));
}

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    NSString *lastUserName  = [[TCSettings performSelector:@selector(sharedTCSettings)] valueForKey:@"last_loggedin_user"];
    NSString *rememberMe    = [[TCSettings performSelector:@selector(sharedTCSettings)] valueForKey:@"last_login_remember_me"];
    NSString *password      = @"";
    if([rememberMe isEqualToString:@"1"]){
        password = [TCPasswordVault passwordForAccount:lastUserName];
    }
    self.model = [[[Session alloc] initWithAttributes:$dict(@"user_name", lastUserName?lastUserName:@"", @"password", password?password:@"", @"last_login_remember_me", rememberMe?rememberMe:@"0") andOptions:$dict()] autorelease];
    if([rememberMe isEqualToString:@"1"]){
        [self performSelector:@selector(login) withObject:nil afterDelay:0];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    __block TCLoginController *this = self;
    $unwatch(@"initiate:login", this.tableView);
    $unwatch(@"start:register", this.tableView);
    $unwatch(@"start:tnc", this.tableView);
    $unwatch(@"login:success");
    $watch(@"initiate:login", this.tableView,  ^(NSNotification *notif){
        [this login];
    });
    $watch(@"start:register", this.tableView,  ^(NSNotification *notif){
        [this startRegister];
    });
    $watch(@"login:success", ^(NSNotification *notif){
        ((Session*)this.model).loggedIn = YES;
    });
    $watch(@"start:tnc", this.tableView,  ^(NSNotification *notif){
        $navigate(@"/www", $dict(@"URL", @"http://cnn.com"));
    });
}

- (Class) formTableClass{
    return [TCLoginView class];
}

- (NSDictionary*) routes{
    __block TCLoginController *this = self;
    return $dict(@"/logout", $block(^(NSNotification* notif){
        [this logout];        
    }));    
}

@end



