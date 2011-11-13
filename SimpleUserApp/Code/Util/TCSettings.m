#import "TCSettings.h"
#import "macros.h"

@implementation TCSettings

SYNTHESIZE_SINGLETON_FOR_CLASS(TCSettings)

@synthesize settings;

+ (TCSettings*) instance{
    return [self performSelector:@selector(sharedTCSettings)];   
}

+ (NSString*) settingsFileName{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/settings.plist"];
}

- (id) init{
    if((self = [super init])){
        NSData  *data = [[[NSData alloc] initWithContentsOfFile:[[self class] settingsFileName]] autorelease];
        if(data){
        	self.settings =	[NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListMutableContainersAndLeaves format:NULL errorDescription:NULL];           
        }
        if(!self.settings){
            self.settings = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

- (id) valueForKey:(NSString*)key{
    return [self.settings objectForKey:key];
}

- (void) saveSettings { 
    NSData  *data = [NSPropertyListSerialization dataFromPropertyList:self.settings format:kCFPropertyListXMLFormat_v1_0 errorDescription:NULL];
    if(data){
        [data writeToFile:[[self class] settingsFileName] atomically:YES];
    }
}

- (void) setValue:(id)value forKey:(NSString*)key{
    if(value){
        [settings setObject:value forKey:key];
    }
    [self saveSettings];
}

- (void) dealloc{
    [self saveSettings];
    self.settings = nil;
    [super dealloc];
}

@end
