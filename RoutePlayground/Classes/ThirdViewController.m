#import "ThirdViewController.h"

@implementation ThirdViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"Third";
}

+ (void) load{
    __block Class this = self;
    $routec(@"/show/:id");    
}

@end
