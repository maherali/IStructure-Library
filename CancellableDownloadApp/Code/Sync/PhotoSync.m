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
    [self cancel];
    NSLog(@"Operation is cancelled");
}

- (BOOL) isUserCancellable{
    return YES;
}

@end
