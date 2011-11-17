#import "MyModel.h"
#import "MySync.h"

@implementation MyModel

+ (Class) syncClass{
    return [MySync class];
}

- (NSString*) pathRoot{
    return @"http://edmullen.net/test/rc.jpg";
}

- (BOOL) resourceExist{
    return [ISResumableSync resourceExistForURL:[self pathRoot] withBaseDir:[[[MyModel syncClass] new] cacheDir]];
}

@end
