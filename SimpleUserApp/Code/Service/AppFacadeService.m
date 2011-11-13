#import "AppFacadeService.h"
#import "TCRegisterationController.h"
#import "TCUIFactory.h"
#import "TCLoginController.h"
#import "TCSettings.h"
#import "TCPasswordVault.h"
#import "Session.h"

/*

 It's better to have an object responsible for starting the app that is different than the App Delegate. App delegate can get bigger without you knowing.
 
*/

static AppFacadeService  *singleton  = nil; // my service is a singleton.

// Use anonymous category to remove warnings. Doesn't prevent outside from calling, though!
@interface AppFacadeService ()
- (Session*) prepareSession;
@end

@implementation AppFacadeService

@synthesize navigationController;
@synthesize observers;

- (id) intWithOptions:(NSDictionary*) options{
    LOG(@"%@", [IStructure version]); // you can always see what build of iStructure you're using!
    self = [super init];
    self.observers = $marray(); // I'm going to be watching things, therefore I always have a mutable array property named observers
    UIWindow *window = [options objectForKey:@"window"];   // you better pass in the window in the options!
    [window addSubview:[TCUIFactory backgroundImageView]]; // let's add our lovely background view. To make use of it, a view will have its background as a clear color.
    [ISModel setBaseUrl:@"http://gentle-lightning-6506.herokuapp.com/"]; // all my models have this base url. You can specify base url for specific model classes or even specific model instances!
    __block AppFacadeService *this = self; // most macros use this to refere to self. Always define it to make your life easy. Never reference properties without using this in the dot notation. You don't want these blocks to retain you!
    Session *session = [self prepareSession]; // Let's create a session object and possibly populate it from last time!
    $watch(@"login:success",  ^(NSNotification *notif){ // I'm going to watch (observe) login:success event triggered by any object.
        // when loggin is successful, I need to store the state for next time.
        [TCPasswordVault savePassword:[session get:@"password"] forAccount:[session get:@"user_name"]];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[session get:@"user_name"] forKey:@"last_loggedin_user"];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[session get:@"last_login_remember_me"] forKey:@"last_login_remember_me"];
    });
    // At the start of the app, I show login 
    // The values passed have two possible entries: params (from the navigation path, which we don't use because we start it manualy) and options with the most important option (the model or collection).
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[[[TCLoginController alloc] initWithValues:$dict(OPTIONS_KEY, $dict(MODEL_KEY, session))] autorelease]] autorelease];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible]; // show it!
    return self;
}

- (Session*) prepareSession{
    NSString *lastUserName  = [[TCSettings performSelector:@selector(sharedTCSettings)] valueForKey:@"last_loggedin_user"];
    NSString *rememberMe    = [[TCSettings performSelector:@selector(sharedTCSettings)] valueForKey:@"last_login_remember_me"];
    NSString *password      = @"";
    if([rememberMe isEqualToString:@"1"]){
        password = [TCPasswordVault passwordForAccount:lastUserName];
    }
    return [[[Session alloc] initWithAttributes:$dict(@"user_name", lastUserName?lastUserName:@"", @"password", password?password:@"", @"last_login_remember_me", rememberMe?rememberMe:@"0") andOptions:$dict()] autorelease];
}

// This class method is called when someone starts my service by issuing $start(@"app")
+ (void) startWithOptions:(NSDictionary*) options{
    singleton = singleton ? singleton : [[self alloc] intWithOptions:options];
}

+ (void) load{
    // When the runtime loads my class, I would like to register this as a service call app.
    // anyone who wants to start me, will have to $start(@"app") and possibly pass in some optins in the second parameter
    __block Class this = self;
    $register(@"app");
}

- (void) dealloc{
    __block AppFacadeService *this = self;
    $unwatch(); // always unwatch to remove your observation points. $unwatch() removes observations to everything!
    self.observers              =   nil;
    self.navigationController   =   nil;
    [super dealloc];
}

@end
