#import "ISBasicSync.h"

/** A Sync class with JSON over HTTP and Offline capabilities
 
 To use, just return this class from the [ISModel syncClass] or [ISCollection synClass] method.
 For a specific database name, use setDBName:andVersion: before synching. Only needs to be done once.
 Data is caches for all requests, to partition the cached data, provide the key in SYNC_CACHE_USER_KEY 
 in th eoptions hash of syncWithOptions: method.
 */
@interface ISEnhancedSync : ISBasicSync


+ (void) setDBName:(NSString*) name andVersion:(NSString*) version;
+ (NSString*) dbName;
+ (NSString*) dbVersion;

@end

extern  NSString* const SYNC_CACHE_USER_KEY;