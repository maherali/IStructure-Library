#import "ISBasicSync.h"

/** A Sync class with JSON over HTTP and Offline capabilities
 
 To use, just return this class from the [ISModel syncClass] or  [ISCollection synClass] method.
 For a specific database name, use setDBName:andVersion: before synching. Only needs to be done once.
 Data is cached for all requests, to partition the cached data, provide the key in `SYNC_CACHE_USER_KEY` 
 in the options hash of syncWithOptions: method.
 */
@interface ISEnhancedSync : ISBasicSync

/** Specify the database name and version.
 
 Databases are stored in Library directory of the apps sandbox.
 
 @param name Database name.
 @param version Database version.
 */
+ (void) setDBName:(NSString*) name andVersion:(NSString*) version;

/** Retrieves the database name
 
 @return Database name
 */
+ (NSString*) dbName;

/** Retrieves database version
 
 @return Database version.
*/
+ (NSString*) dbVersion;

@end

extern  NSString* const SYNC_CACHE_USER_KEY;