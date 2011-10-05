#import "FirstViewController.h"

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary*) _passedInValues{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil andValues:_passedInValues];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (NSDictionary*) routes{
    __block FirstViewController *this = self;
    return $dict(@"/secondTab", $block(^(NSNotification* notif){
        [this.tabBarController setSelectedIndex:1];
    }));    
}

- (IBAction)switchToSecondTab:(id)sender{
    __block FirstViewController *this = self;
    $navigate(@"/secondTab");
}

@end
