@interface ISRouteEntry : NSObject

@property (nonatomic, retain)   NSString    *controllerName;
@property (nonatomic, retain)   NSString    *action;
@property (nonatomic, retain)   NSString    *routePattern;

- (ISRouteEntry*) initWithController:(NSString*) ctrl action:(NSString*) act andRoute:(NSString*) pattern;
+ (ISRouteEntry*) routeEntryWithController:(NSString*) ctrl action:(NSString*) act andRoute:(NSString*) pattern;

@end
