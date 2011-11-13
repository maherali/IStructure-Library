#import "TCPasswordVault.h"

const NSString *serviceName = @"com.agilismobility.simpleuserapp";

@implementation TCPasswordVault

+ (NSDictionary*) queryForAccount:(NSString*) account{
    NSMutableDictionary *genericQuery = [[[NSMutableDictionary alloc] init] autorelease];  
    [genericQuery setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData *encodedAccount = [account dataUsingEncoding:NSUTF8StringEncoding];
    [genericQuery setObject:encodedAccount forKey:(id)kSecAttrGeneric];
    [genericQuery setObject:encodedAccount forKey:(id)kSecAttrAccount];
    [genericQuery setObject:serviceName forKey:(id)kSecAttrService];
    return genericQuery; 
}

+ (NSString*) passwordForAccount:(NSString*) account{
    NSData   *result = nil;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self queryForAccount:account]];
    [attributes setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [attributes setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)attributes, (CFTypeRef *)&result);
    if(status == noErr){
        NSString *p =  [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease];
        return p;
    }else{
        return nil;
    }
}

+ (BOOL) savePassword:(NSString*) password forAccount:(NSString*) account{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self queryForAccount:account]];
    OSStatus status = 0;
    if(![self passwordForAccount:account]){
        [attributes setObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
        status = SecItemAdd((CFDictionaryRef)attributes, NULL);
    }else{
        NSMutableDictionary *updateDictionary = [[[NSMutableDictionary alloc] init] autorelease];
        [updateDictionary setObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
        status = SecItemUpdate((CFDictionaryRef)attributes, (CFDictionaryRef)updateDictionary);
    }
    return status == noErr;
}

@end
