@interface MultimediaSync : ISBasicSync


@property (nonatomic, retain)   NSString    *cacheDir;

+ (NSString*) potentialResourceFilePath:(NSString*) url withBaseDir:(NSString*) baseDir;
+ (NSString*) potentialDownloadFilePath:(NSString*) url withBaseDir:(NSString*) baseDir;
+ (NSData*) resourceOnDiskForURL:(NSString*) url withBaseDir:(NSString*) baseDir;
+ (NSData*) partialDownloadOnDiskForURL:(NSString*) url withBaseDir:(NSString*) baseDir;
+ (BOOL) resourceExistForURL:(NSString*) url withBaseDir:(NSString*) basDir;
+ (BOOL) partialDownloadExistForURL:(NSString*) url withBaseDir:(NSString*) basDir;
+ (void) createDirectory:(NSString*) dir;
+ (unsigned long long) fileSize:(NSString*) filePath;
+ (NSDate*) fileModificationDate:(NSString*) filePath;
    

@end
