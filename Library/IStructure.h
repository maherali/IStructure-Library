#import "NSString+ISStructure.h"
#import "NSNotificationCenter+ISStructure.h"
#import "ISObserver.h"
#import "NSDate+ISStructure.h"
#import "NSData+ISStructure.h"
#import "CollectionUtils.h"
#import "SPDeepCopy.h"
#import "SBJson.h"
#import "ISErrorDecoder.h"
#import "ISMacros.h"
#import "ISSync.h"
#import "ISCacheDatabase.h"
#import "ISBasicSync.h"
#import "ISEnhancedSync.h"
#import "ISErrorDecoder.h"
#import "ISBasicErrorDecoder.h"
#import "ISModel.h"
#import "ISCollection.h"
#import "ISRouteEntry.h"
#import "ISRoute.h"
#import "ISRouter.h"
#import "UIAlertView+ISStructure.h"
#import "ISViewController.h"
#import "ISTableView.h"
#import "ISTableViewController.h"
#import "ISBaseView.h"

#define $extend(HASHES...)     ({NSDictionary *hashes[]={HASHES}; \
 _extend(hashes,sizeof(hashes)/sizeof(NSDictionary *));});

void _extend(NSDictionary**, size_t count);



@interface IStructure : NSObject 


@end