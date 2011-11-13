#import "SecondViewController.h"

@implementation SecondViewController

@synthesize navigateField, installField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary*) _passedInValues{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil andValues:_passedInValues];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void) dismiss:(NSTimer*) t{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSDictionary*) routes{
    __block SecondViewController *this = self;
    return $dict(@"/firstTab", $block(^(NSNotification* notif){
        [this.tabBarController setSelectedIndex:0];
    }), @"/empty", $block(^(NSNotification *notif){
        if(arc4random()%2){
            [this presentViewController:[[[UIViewController alloc] initWithNibName:@"SampleViewController" bundle:nil] autorelease] animated:YES completion:^{
                [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismiss:) userInfo:nil repeats:NO];
            }];
        }else{
            [this.navigationController pushViewController:[[[UIViewController alloc] initWithNibName:nil bundle:nil] autorelease] animated:YES];
        }
    }));    
}

- (IBAction)switchToFirstTab:(id)sender{
    __block SecondViewController *this = self;
    $navigate(@"/firstTab");
}

- (IBAction)pushOnNavigationBar:(id)sender{
    __block SecondViewController *this = self;
    $navigate(@"/empty");
}

- (IBAction)navigateToRoute:(id)sender{
    __block SecondViewController *this = self;
    [this.navigateField resignFirstResponder];
    $navigate(this.navigateField.text);
}

- (NSArray*) realParams:(NSDictionary*) dict{
    NSMutableArray *arr = $marray();
    for(id key in [dict allKeys]){
        [arr addObject:$sprintf(@"%@ : %@", key, [dict objectForKey:key])];
    }
    return arr;
}

- (IBAction)installRemoveRoute:(id)sender{
    __block SecondViewController *this = self;
    if($route_exist(this.installField.text)){
        $unroute(this.installField.text);
        [UIAlertView message:@"Route has been removed!"];
    }else{
        $route(this.installField.text, $block(^(NSNotification *notif){
            [UIAlertView allParams:[this realParams:[notif.userInfo objectForKey:PARAMS_KEY]]];
        }));
        [UIAlertView message:@"Route has been added!"];
    }
    [this.installField resignFirstResponder];
}

- (void) dealloc{
    __block SecondViewController *this = self;
    $unwatch();
    self.navigateField  =   nil;
    self.installField   =   nil;
    [super dealloc];
}

@end
