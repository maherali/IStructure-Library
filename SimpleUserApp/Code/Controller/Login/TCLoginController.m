#import "TCLoginController.h"
#import "TCLoginView.h"

@implementation TCLoginController

- (Class) formTableClass{
    return [TCLoginView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

@end
