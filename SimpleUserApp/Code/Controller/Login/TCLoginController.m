#import "TCLoginController.h"
#import "TCLoginView.h"
#import "Session.h"
#import "Registration.h"
#import "TCUIFactory.h"

@interface TCLoginController ()

- (void) login;
- (void) logout;
- (void) startRegister;

@end 

@implementation TCLoginController

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style]; // The parent class extracts the options and params from passedInValues parameter. It also extracts teh model and collection objects passed in options.
    NSString *rememberMe = [self.model get:@"remember_me"]; // the model was extracted in the base class
    if([rememberMe isEqualToString:@"YES"]){
        // Log in automatically if remember was on from the last login session
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
    // Since the view may unload during memory shortages, unwatch previously observed events
    $unwatch(@"initiate:login", this.tableView);
    $unwatch(@"start:register", this.tableView);
    $unwatch(@"start:tnc", this.tableView);
    
    $watch(@"initiate:login", this.tableView,  ^(NSNotification *notif){
        //TODO: get the attributes from the user infor passed by the view and check 
        [this login];
    });
    $watch(@"start:register", this.tableView,  ^(NSNotification *notif){
        [this startRegister];
    });
    $watch(@"start:tnc", this.tableView,  ^(NSNotification *notif){
        $navigate(@"/www", $dict(@"URL", @"http://www.apple.com/legal/itunes/us/terms.html"));
    });
}

- (void) login{
    __block TCLoginController *this = self;
    if(((Session*)self.model).loggedIn){
        [UIAlertView message:@"You are already logged in!"];
        $navigate(@"/welcome");
        return;
    }
    $trigger(@"login:begin", this.model);
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        $trigger(@"login:end", this.model);
        $trigger(@"login:success");
        $navigate(@"/welcome");
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        $trigger(@"login:end", this.model);
        [UIAlertView errors:errors];
    }))];
}

- (void) logout{
    __block TCLoginController *this = self;
    [self.model destroy:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        $trigger(@"logout:success");
    }), FAILURE_HANDLER_KEY, [TCUIFactory commonErrorHandler])];
}

- (void) startRegister{
    __block TCLoginController *this = self;
    Registration *reg = [[[Registration alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    $navigate(@"/register", $dict(MODEL_KEY, reg)); // navigate to register and pass in the Registration model in options
}

- (Class) formTableClass{
    return [TCLoginView class]; // our form view class is specified here
}

- (NSDictionary*) routes{
    // The ISViewController or ISTableViewController calls this method at initialization and 
    // adds a route for each one using $route(key, block) key: /logout, block: the block specified
    __block TCLoginController *this = self;
    return $dict(@"/logout", $block(^(NSNotification* notif){
        [this logout];        
    }));    
}

@end



