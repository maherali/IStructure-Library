#import "PhotoSync.h"

@implementation PhotoSync

- (NSString*) loadingMessage{
    NSString    *method     = [self.options objectForKey:METHOD_KEY];
	if ([method isEqualToString:METHOD_READ]) {
        return @"Fetching Photo...";
	}		
    return nil;
}

- (BOOL) showsLoading{
    return YES;    
}

- (void) operationIsCancelled{
    [super cancel];
}

- (BOOL) isUserCancellable{
    return YES;
}

- (BOOL) startsImmediately{
    return NO;
}

@end
