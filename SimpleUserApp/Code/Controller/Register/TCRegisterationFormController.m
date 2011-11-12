#import "TCRegisterationFormController.h"
#import "TCRegistrationFormView.h"
#import "TCUIFactory.h"
//#import "TCTripNavigationBar.h"

@implementation TCRegisterationFormController

- (Class) formTableClass{
    return [TCRegistrationFormView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [[self navigationItem] setLeftBarButtonItem:[TCUIFactory backButtonForTarget:self andAction:@selector(goBack)]];
    [[self navigationItem] setRightBarButtonItem:[TCUIFactory editRefreshButtonsForTarget:self editAction:@selector(editAction) refreshAction:@selector(refreshAction)]];
  //  [self.navigationController.navigationBar addSubview:[TCTripNavigationBar navBar]]; 
}

- (void) goBack{
    
}

- (void) editAction{
    
}

- (void) refreshAction{
    
}

@end
