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

- (void) fetch:(NSDictionary *)options{
    [super fetch:options];
    __block MyModel *this           = self;
    __block float totalSofar   = 0; 
    __block float totalLength  = 0;
    
    $unwatch();
    
    $watch(@"content-length", self.sync, ^(NSNotification *notif){
        NSString *length = [notif.userInfo objectForKey:@"length"];
        totalLength = [length longLongValue];
    });
    
    $watch(@"cached-data-count", self.sync, ^(NSNotification *notif){
        NSString *length = [notif.userInfo objectForKey:@"length"];
        totalSofar = [length longLongValue];
    });
    $watch(@"received-data-count", self.sync, ^(NSNotification *notif){
        NSString *length = [notif.userInfo objectForKey:@"length"];
        totalSofar += [length longLongValue];
        float percentageSoFar = totalSofar/totalLength*100.0f;
        if(percentageSoFar >= 100.0005f){
            percentageSoFar = 100.0f;
        }
        $trigger(@"percentage_retrieved", $dict(@"value", $sprintf(@"%f", percentageSoFar)));
        LOG(@"Received the data in model %@", length);
    });
    [self.sync start];
}

@end
