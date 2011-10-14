#import "ISBasicSync.h"

@interface ISEnhancedSync : ISBasicSync


+ (void) setDBName:(NSString*) name andVersion:(NSString*) version;
+ (NSString*) dbName;
+ (NSString*) dbVersion;

@end
