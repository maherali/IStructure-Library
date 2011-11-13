#import "AppFacadeService.h"
#import "TCRegisterationController.h"
#import "TCUIFactory.h"
#import "TCLoginController.h"
#import "TCSettings.h"
#import "TCPasswordVault.h"
#import "Session.h"

static AppFacadeService    *singleton  = nil;

@interface AppFacadeService ()
- (Session*) prepareSession;
@end

@implementation AppFacadeService

@synthesize navigationController;
@synthesize observers;

- (id) intWithOptions:(NSDictionary*) options{
    self = [super init];
    self.observers = $marray();
    UIWindow *window = [options objectForKey:@"window"];   
    [window addSubview:[TCUIFactory backgroundImageView]];
    LOG(@"%@", [IStructure version]);
    [ISModel setBaseUrl:@"http://gentle-lightning-6506.herokuapp.com/"];
    __block AppFacadeService *this = self;
    Session *session = [self prepareSession];
    $watch(@"login:success",  ^(NSNotification *notif){
        [TCPasswordVault savePassword:[session get:@"password"] forAccount:[session get:@"user_name"]];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[session get:@"user_name"] forKey:@"last_loggedin_user"];
        [[TCSettings performSelector:@selector(sharedTCSettings)] setValue:[session get:@"last_login_remember_me"] forKey:@"last_login_remember_me"];
    });
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[[[TCLoginController alloc] initWithValues:$dict(OPTIONS_KEY, $dict(MODEL_KEY, session))] autorelease]] autorelease];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
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


+ (void) startWithOptions:(NSDictionary*) options{
    singleton = singleton ? singleton : [[self alloc] intWithOptions:options];
}

+ (void) load{
    __block Class this = self;
    $register(@"app");
}

- (void) dealloc{
    __block AppFacadeService *this = self;
    $unwatch();
    self.observers              =   nil;
    self.navigationController   =   nil;
    [super dealloc];
}

@end
