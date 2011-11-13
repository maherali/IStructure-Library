#import "UIApplication+Extensions.h"

@implementation UIApplication (NetworkExtensions)

#define ReachableViaWiFiNetwork          2
#define ReachableDirectWWAN              (1 << 18)

+ (const char*) getBaseHost {
    return "google.com";
}

+(BOOL)hasActiveWiFiConnection{
    SCNetworkReachabilityFlags          flags;
    SCNetworkReachabilityRef            reachabilityRef;
    BOOL                                gotFlags;
    reachabilityRef     = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [self getBaseHost]);
    if (reachabilityRef) {
		gotFlags = SCNetworkReachabilityGetFlags(reachabilityRef, &flags);
		CFRelease(reachabilityRef);
	} else {
		gotFlags = 0;
	}
    if (!gotFlags)                          return NO;
    if(flags & ReachableDirectWWAN)         return NO;
    if(flags & ReachableViaWiFiNetwork)     return YES;
    return NO;
}

+ (BOOL) hasNetworkConnection{
    SCNetworkReachabilityFlags          flags;
    SCNetworkReachabilityRef            reachabilityRef;
    BOOL                                gotFlags;
    reachabilityRef     = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [self getBaseHost]);
    if (reachabilityRef) {
		gotFlags = SCNetworkReachabilityGetFlags(reachabilityRef, &flags);
		CFRelease(reachabilityRef);
	} else {
		gotFlags = 0;
	}
    if (!gotFlags || (flags == 0))  return NO;
    return YES;
}

@end
