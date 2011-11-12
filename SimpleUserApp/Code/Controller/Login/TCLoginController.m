#import "TCLoginController.h"
#import "TCLoginView.h"

@implementation TCLoginController


- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    
    
    __block TCLoginController *this = self;
    $watch(@"note:title:selected", ^(NSNotification *notif){
       
    });

    
    return self;
}

- (Class) formTableClass{
    return [TCLoginView class];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

@end
