#import "TCRegisterationController.h"
#import "TCRegistrationView.h"
#import "TCUIFactory.h"
#import "Registration.h"

@implementation TCRegisterationController

- (void) signup{
    __block TCRegisterationController *this = self;
    LOG(@"Registration attributes: %@", self.model);
    $trigger(@"internet:begin", this.model);
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Registration *model, NSData *data){
        $trigger(@"internet:end", this.model);
        [UIAlertView message:$array(@"Successful Registration!")];
        $navigate(@"/welcome");
    }), FAILURE_HANDLER_KEY, $block(^(Registration *model, NSArray *errors){
        $trigger(@"internet:end", this.model);
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
    [[self navigationItem] setRightBarButtonItem:[TCUIFactory editRefreshButtonsForTarget:self editAction:@selector(editAction) refreshAction:@selector(refreshAction)]];
    
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


@end
