#import "MyModel.h"
#import "MySync.h"

@implementation MyModel

+ (Class) syncClass{
    return [MySync class];
}

- (NSString*) pathRoot{
    return [self get:@"URL"];
}

- (BOOL) resourceExist{
    return [ISResumableSync resourceExistForURL:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]];
}

- (void) removeResource{
    [ISResumableSync removeResourceOnDisk:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]]; 
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
        $trigger(@"percentage_retrieved", $dict(@"value", $sprintf(@"%f", percentageSoFar)));
    });
    [self.sync start];
}

@end
