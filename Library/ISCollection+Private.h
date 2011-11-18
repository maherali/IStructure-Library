#ifndef New_Architecture_ISCollection_Private
#define New_Architecture_ISCollection_Private

#import "ISCollection.h"

@interface  ISCollection ()

@property   (retain)    NSMutableArray          *observers;
@property   (retain)    NSMutableDictionary     *_byCid;
@property   (retain)    NSMutableDictionary     *_byId;

- (void) _reset;

@end

#endif
