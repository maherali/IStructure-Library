#import "sqlite3.h"

@interface ISCacheDatabase : NSObject {
    sqlite3             *database;
    NSString            *dbName;
    NSString            *version;
}
@property   (nonatomic, retain) NSString    *dbName;
@property   (nonatomic, retain) NSString    *version;

+ (char *) cString:(NSString *)str;
+ (ISCacheDatabase*) sharedDBWithName:(NSString*) theDBName andVersion:(NSString*) theVersion;
+ (void) closeConnectionToDBWithName:(NSString*) theDBName;
- (id) initWithDBName:(NSString*) theDBName andVersion:(NSString*) theVersion;
- (void) createTables;
- (BOOL) openDatabase;
- (BOOL) cacheURL:(NSString*)theURL withData:(NSString*)theData;
- (BOOL) cacheURL:(NSString*)theURL forUser:(NSString*)theUser andData:(NSString *)theData;
- (NSString*) dataForURL:(NSString*)theURL;
- (NSString*) dataForUserID:(NSString*)_user andURL:(NSString*)_url;
- (NSString*) dbVersion;
- (BOOL) setDBVersion;

@end
