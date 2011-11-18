#import "MyModel.h"
#import "MySync.h"

@implementation MyModel

@synthesize percentage, image;

- (UIImage*) image{
    if(!image){
        if([self resourceExist]){
            return [UIImage imageWithData:[ISResumableSync resourceOnDiskForURL:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]]];
        }
    }
    return image;
}

+ (Class) syncClass{
    return [MySync class];
}

- (NSString*) pathRoot{
    return [self get:@"URL"];
}

- (BOOL) resourceExist{
    return [ISResumableSync resourceExistForURL:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]];
}

- (NSString*) resourcePathOnDisk{
    return [ISResumableSync potentialResourceFilePath:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]];
}

- (void) removeResource{
    [ISResumableSync removeResourceOnDisk:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]]; 
}

- (NSDictionary*) parse:(NSData*) data{
    self.image = [UIImage imageWithData:data];
    return $dict(@"loaded", $object(YES));
}

- (void) fetch:(NSDictionary *)options{
    [super fetch:options];
    __block MyModel *this           = self;
    __block float totalSofar        = 0.0f; 
    __block float totalLength       = 0.0f;
    
    $unwatch();
    $watch(@"content-length", self.sync, ^(NSNotification *notif){
        totalLength = [[notif.userInfo objectForKey:@"length"] longLongValue];
    });
    $watch(@"cached-data-count", self.sync, ^(NSNotification *notif){
        totalSofar = [[notif.userInfo objectForKey:@"length"] longLongValue];
    });
    $watch(@"received-data-count", self.sync, ^(NSNotification *notif){
        totalSofar += [[notif.userInfo objectForKey:@"length"] longLongValue];
        float percentageSoFar = totalSofar/totalLength*100.0f;
        if(percentageSoFar >= 100.0005f){
            percentageSoFar = 100.0f;
        }
        percentage = percentageSoFar;
        $trigger(@"percentage_retrieved", $dict(@"value", $sprintf(@"%f", percentageSoFar)));
    });
    [self.sync start];
}

- (void)dealloc {
    self.image  =   nil;
    [super dealloc];
}
@end
