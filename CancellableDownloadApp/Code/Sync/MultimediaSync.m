#import "MultimediaSync.h"

#define IS_MM_CACHE_DIR_PATH    @"Library"

@implementation MultimediaSync

@synthesize cacheDir;


- (id<ISSyncProtocol>)  initWithOptions:(NSDictionary*) options{
    self = [super initWithOptions:options];
    if(self){
        
    }
    return self;
}

- (void) initiateSync{
    if(!self.cacheDir){
        self.cacheDir   = IS_MM_CACHE_DIR_PATH;
    }
    NSURL       *url        = [NSURL URLWithString:[self.options objectForKey:URL_KEY]];
    if ([MultimediaSync resourceExistForURL:[url absoluteString] withBaseDir:self.cacheDir ]) {
        self.data = [[[MultimediaSync resourceOnDiskForURL:[url absoluteString] withBaseDir:self.cacheDir ] mutableCopy] autorelease];
        [self finish];
    }else{
        [self send:[self lastChanceToUpdateRequest:[self buildRequest]]];
    }
}

- (void)dealloc {
    self.cacheDir   =   nil;
    [super dealloc];
}

+ (NSString*) potentialResourceFilePath:(NSString*) url withBaseDir:(NSString*) baseDir{
    NSString    *afterCleaning = [url stringByReplacingOccurrencesOfString:@":" withString:@""];
    afterCleaning = [afterCleaning stringByReplacingOccurrencesOfString:@"/" withString:@""];
    afterCleaning = [afterCleaning stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString    *fileName = [NSHomeDirectory() stringByAppendingPathComponent:baseDir];
    fileName = [fileName stringByAppendingPathComponent:afterCleaning];
    return fileName;
}

+ (NSString*) potentialDownloadFilePath:(NSString*) url withBaseDir:(NSString*) baseDir{
    NSString *filePath = [self potentialResourceFilePath:url withBaseDir:baseDir];
    return [filePath stringByAppendingPathComponent:@".download"];
}

+ (NSData*) resourceOnDiskForURL:(NSString*) url withBaseDir:(NSString*) baseDir{
    return [NSData dataWithContentsOfFile:[self potentialResourceFilePath:url withBaseDir:baseDir]];
}

+ (NSData*) partialDownloadOnDiskForURL:(NSString*) url withBaseDir:(NSString*) baseDir{
    return [NSData dataWithContentsOfFile:[self potentialDownloadFilePath:url withBaseDir:baseDir]];
}

+ (BOOL) resourceExistForURL:(NSString*) url withBaseDir:(NSString*) basDir{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self potentialResourceFilePath:url withBaseDir:basDir]];
}

+ (BOOL) partialDownloadExistForURL:(NSString*) url withBaseDir:(NSString*) basDir{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self potentialDownloadFilePath:url withBaseDir:basDir]];
}

+ (void) createDirectory:(NSString*) dir{
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:dir] withIntermediateDirectories:YES attributes:nil error:NULL];
}

+ (unsigned long long) fileSize:(NSString*) filePath{
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL] fileSize];
}

+ (NSDate*) fileModificationDate:(NSString*) filePath{
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL] fileModificationDate];
}



//-
//(void) storeResourceToDisk{
//    NSData *data = UIImageJPEGRepresentation(resourceRecord.image, 1.0);
//    [data writeToFile:[self resourcePotentialFileNameOnDisk] atomically:YES];
//}

@end
