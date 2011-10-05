#define SYNC_DATA_ARG_KEY                    @"SYNC_DATA_ARG_KEY"
#define SYNC_META_DATA_ARG_KEY               @"SYNC_META_DATA_ARG_KEY"

typedef void(^SyncHandler)(NSData *data, NSDictionary *metaData);

@protocol ISSyncProtocol <NSObject>

+ (id<ISSyncProtocol>)  syncWithOptions:(NSDictionary*) options;
- (id<ISSyncProtocol>)  initWithOptions:(NSDictionary*) options;
- (void)                initiateSync;
- (BOOL)                hasAppLevelErrors;
- (NSArray*)            appLevelErrors;
- (BOOL)                hasNetworkLevelErrors;
- (NSArray*)            networkLevelErrors;
- (NSDictionary*)       callbackArgs;

@end

@interface ISSync : NSObject<ISSyncProtocol>

@property   (retain)    NSDictionary    *options;
@property   (retain)    ISErrorDecoder  *errorDecoder;

- (void)    sync:(NSThread*) callerThread;
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
