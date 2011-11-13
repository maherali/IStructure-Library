#import <SystemConfiguration/SCNetworkReachability.h>

@interface UIApplication (NetworkExtensions)

+ (BOOL) hasActiveWiFiConnection;     
+ (BOOL) hasNetworkConnection;     

@end
