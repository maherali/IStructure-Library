#import "AppDelegate.h"
#import "Photo.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize photo;

- (void) fetchPhoto{
    self.photo = [[[Photo alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    [photo fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(Photo *model, NSData *data){
        [UIAlertView message:@"Success fetching photo!"];
    }), FAILURE_HANDLER_KEY, $block(^(Photo *model, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.window.bounds.size.width/2.0f - 50, self.window.bounds.size.height-220, 100, 50);
    [button setTitle:@"Fetch" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(fetchPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [ISModel setBaseUrl:@"http://edmullen.net/test/"];
    [self fetchPhoto];
}

- (void)dealloc{
    self.photo = nil;
    [_window release];
    [super dealloc];
}

@end
