#import "AppDelegate.h"
#import "Photo.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize photo;

- (void) fetchPhoto{
    UIImageView *imageView = (UIImageView*) [self.window viewWithTag:12345];
    imageView.image = nil;
    self.photo = [[[Photo alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    [photo fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(Photo *model, NSData *data){
        imageView.image = self.photo.image;
    }), FAILURE_HANDLER_KEY, $block(^(Photo *model, NSArray *errors){
        [UIAlertView errors:errors];
    }), CANCEL_HANDLER_KEY, $block(^(Photo *model, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor]; 
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.window.bounds] autorelease];
    imageView.tag = 12345;
    [self.window addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.window.bounds.size.width/2.0f - 50, self.window.bounds.size.height/2.0f-25.0f, 100, 50);
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
