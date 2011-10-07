#import "ISObserver.h"

@interface ISRouter : NSObject 

typedef void (^Navigator)(NSArray*);
typedef void (^ISActionBlock)(NSNotification*);

+ (void)    routeControllerName:(NSString*) controllerName withAction:(NSString*) action toRoutePattern:(NSString*) routePattern;
+ (void)    routePattern:(NSString*) routePattern toController:(id) controller withBlock:(ISActionBlock) block;
+ (void)    navigate:(NSString*) to withOptions:(NSDictionary*) _options;
+ (void)    navigate:(NSString*) to withNavCtrl:(UINavigationController*) nav andOptions:(NSDictionary*) _options;
+ (void)    unroutePattern:(NSString*) routePattern fromController:(id) controller;
+ (void)    registerService:(NSString*) serviceName toServiceClass:(NSString*) serviceClass;
+ (void)    startService:(NSString*) serviceName withOptions:(NSDictionary*) options;
+ (void)    stopService:(NSString*) serviceName withOptions:(NSDictionary*) options;
+ (BOOL)    routeExist:(NSString*) to;
@end







