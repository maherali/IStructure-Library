#import "TCRegisterationController.h"
#import "TCRegistrationView.h"
#import "TCUIFactory.h"
//#import "TCTripNavigationBar.h"

@implementation TCRegisterationController

- (void) signup{
    LOG(@"should call server now!");
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
