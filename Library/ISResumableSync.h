@interface ISResumableSync : ISBasicSync{
    NSFileHandle    *downloadFileHandler;
}

@property (nonatomic, retain)   NSFileHandle    *downloadFileHandler;

/**
 The cache location in the application Sandbox. Default is Library/IStructure-Cache
 
 @return The cache path relative to the app sandbox.
 */
- (NSString*) cacheDir;

/**
 Determines whether the resource is cached on disk.
 
 @return A YES iff the resource exists on disk.
 */
- (BOOL) resourceExists;

/**
 Obtains the data cached for the URL
 
 @return AN instance of NSData representing teh cached data for the resource URL. nil, otherwise.
 */

- (NSData*) resourceData;


/**
 Detarmines whether the partial resource exists for the resource URL.
 
 @return YES iff a portion of the download exists.
 */
- (BOOL) partialResourceExists;

/**
 Obtains the data for the portion of the resource successfully obtained.
 
 @return An NSData instance representing the data for the parial resource on disk.
 */
- (NSData*) partialResourceData;

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
