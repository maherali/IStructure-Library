#define SYNC_DATA_ARG_KEY                    @"SYNC_DATA_ARG_KEY"
#define SYNC_META_DATA_ARG_KEY               @"SYNC_META_DATA_ARG_KEY"

typedef void(^SyncHandler)(NSData *data, NSDictionary *metaData);

/** Protocol for synchronizing model/collection.
*/
@protocol ISSyncProtocol <NSObject>

/** Method to initiate synching with options.
 
 ISync class implements that simply by forking a background thread on sync: as follows:
 
    + (id<ISSyncProtocol>) syncWithOptions:(NSDictionary*) _options{
        ISSync *sync = [[[self alloc] initWithOptions:_options] autorelease];
        [sync performSelectorInBackground:@selector(sync:) withObject:[NSThread currentThread]];
        return sync;
    }
 
 This behaviour should be sufficient for most apps.
 
 
 @return The id\<ISSyncProtocol\> instance.
 @param options The options to use in the synchronization.
*/
+ (id<ISSyncProtocol>)  syncWithOptions:(NSDictionary*) options;

/** Initializes the instance.
 ISync has the following implementation of this method:
 
    - (id<ISSyncProtocol>) initWithOptions:(NSDictionary*) _options{
        self = [super init];
        self.options        =   _options;
        self.errorDecoder   =   [[[self class] errorDecoderClass] errorDecoder];
        return self;
    }
 
 This behaviour should be sufficient for most apps.
 */
- (id<ISSyncProtocol>)  initWithOptions:(NSDictionary*) options;

/** Start teh actual synchronization.
 */
- (void)                initiateSync;

/** Determines if there are app-level errors.
 Base implementation proxy that to the errorDecoder instance.
 */

- (BOOL)                hasAppLevelErrors;

/** Computes the app-level errors.
 Base implementation proxy that to the errorDecoder instance.
 */
- (NSArray*)            appLevelErrors;

/** Determines if there are network-level errors.
 Base implementation proxy that to the errorDecoder instance.
*/
- (BOOL)                hasNetworkLevelErrors;

/** Computes the network-level errors.
 Base implementation proxy that to the errorDecoder instance.
 */
- (NSArray*)            networkLevelErrors;

/** Computes the two arguments (data, and metadata) to use in 
 invoking either success/failure handlers. See the discussions in sync:.
 */
- (NSDictionary*)       callbackArgs;

@end

@interface ISSync : NSObject<ISSyncProtocol>

/** Options used in synchronization.
 */
@property   (retain)    NSDictionary    *options;

/** The error decoder instance. This instance is responsible 
 for decoding both network and aplication errors.
 */
@property   (retain)    ISErrorDecoder  *errorDecoder;

/** The mothod used to initiate sync. 
 
 The method assumes that `options` has been set. It's usually executed in 
 a background thread (not the main UI thread). As such, it uses its own autorelease pool.
 
 You can pass in a Sync handler (type SyncHandler) for success in `options` using the `SYNC_SUCCESS_HANDLER_KEY` key.
 You can also pass in a SyncHandler for failure in `options` using the `SYNC_FAILURE_HANDLER_KEY` key.
 Depending on the outcome of synchronization, either one will be invoked.
 
 The method first sends a `initiateSync` message to itself. implementation of `initiateSync` in the ISync base class is a noop.
 After that, it sends a `hasNetworkLevelErrors` message to itself to determine if there are network-level errors. If 
 there are, it invokes the failure handler on the `callerThread`. Otherwise, the success handler is invoked (also on the 
 `callerThread`). When invoking a failure/success call back, it asks itself for the arguments by sending itself a 
 `callbackArgs` message. This method should return a dictionary of two values:
 
 1. The data in a `SYNC_DATA_ARG_KEY` key.
 2. The metadata in a `SYNC_META_DATA_ARG_KEY` key.
 
 The data and the metadata are the only two parameters used in calling either of the two sync handlers.
 
 Default implementation in ISync returns empty dictionary.
 
 @param callerThread The thread that called sync.
 */
- (void)    sync:(NSThread*) callerThread;

/** The class to use for net/app error decoding.
 */
+ (Class)   errorDecoderClass;

@end

extern  NSString* const METHOD_KEY;
extern  NSString* const DATA_KEY;
extern  NSString* const URL_KEY;
extern  NSString* const METHOD_READ;
extern  NSString* const METHOD_UPDATE;
extern  NSString* const METHOD_DELETE;
extern  NSString* const METHOD_CREATE;
extern  NSString* const SYNC_SUCCESS_HANDLER_KEY;
extern  NSString* const SYNC_FAILURE_HANDLER_KEY;
extern  NSString* const SYNC_CONTINUES_KEY;

