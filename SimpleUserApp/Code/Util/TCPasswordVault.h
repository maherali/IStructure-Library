@interface TCPasswordVault : NSObject

+ (NSString*) passwordForAccount:(NSString*) account;
+ (BOOL) savePassword:(NSString*) password forAccount:(NSString*) account;

@end

extern const NSString* serviceName;
