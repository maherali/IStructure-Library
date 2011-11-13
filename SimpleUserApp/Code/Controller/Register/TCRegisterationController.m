#import "TCRegisterationController.h"
#import "TCRegistrationView.h"
#import "TCUIFactory.h"
#import "Registration.h"

@implementation TCRegisterationController

- (void) signup{
    __block TCRegisterationController *this = self;
    $trigger(@"register:begin", this.model);
    [self.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Registration *model, NSData *data){
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

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [[self navigationItem] setLeftBarButtonItem:[TCUIFactory backButtonForTarget:self andAction:@selector(goBack)]];    
    __block TCRegisterationController *this = self;
    $unwatch(@"initiate:register", this.tableView);
    $unwatch(@"start:tnc", this.tableView);

    $watch(@"initiate:register", this.tableView,  ^(NSNotification *notif){
        [this signup];
    });
    $watch(@"start:tnc", this.tableView,  ^(NSNotification *notif){
        $navigate(@"/www", $dict(@"URL", @"http://www.apple.com/legal/itunes/us/terms.html"));
    });
}

- (void) goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (Class) formTableClass{
    return [TCRegistrationView class];
}

+ (void) load{
    __block Class this = self;
    $routec(@"/register");
}

@end
