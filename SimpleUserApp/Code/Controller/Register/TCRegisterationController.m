#import "TCRegisterationController.h"
#import "TCRegistrationView.h"
#import "TCUIFactory.h"
#import "Registration.h"

@implementation TCRegisterationController

- (void) signup{
    __block TCRegisterationController *this = self;
    $trigger(@"register:begin", this.model);
    
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Registration *model, NSData *data){
        LOG(@"current thread is main thread? %d", [[NSThread currentThread] isMainThread]);
        $trigger(@"register:end", this.model);
        $trigger(@"login:success");
        [UIAlertView message:$array(@"Successful Registration!")];
        $navigate(@"/welcome");
        [this performSelector:@selector(removeFromParentViewController) withObject:nil afterDelay:0];
    }), FAILURE_HANDLER_KEY, $block(^(Registration *model, NSArray *errors){
        $trigger(@"register:end", this.model);
        [UIAlertView errors:errors];
    }))];
}

- (Class) formTableClass{
    return [TCRegistrationView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [[self navigationItem] setLeftBarButtonItem:[TCUIFactory backButtonForTarget:self andAction:@selector(goBack)]];    
    __block TCRegisterationController *this = self;
    $unwatch(@"initiate:register", this.tableView);
    $watch(@"initiate:register", this.tableView,  ^(NSNotification *notif){
        [this signup];
    });
}

- (void) goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) editAction{
    
}

- (void) refreshAction{
    
}

+ (void) load{
    __block Class this = self;
    $routec(@"/register");
}

- (void) dealloc{
    [super dealloc];
}

@end
