#ifndef New_Architecture_ISSync_Private
#define New_Architecture_ISSync_Private

#import "ISSync.h"

@interface  ISSync ()

@property (nonatomic, retain) NSMutableArray        *observers;

- (void) _callBack:(id) block;

@end

#endif
