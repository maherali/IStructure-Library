@interface ISCollection : NSObject{
    NSMutableArray          *observers;
     NSString               *collectionBaseUrl;
}

@property   (retain)    NSMutableArray          *models;
@property   (retain)    ISBasicSync             *sync;
@property   (retain)    NSMutableArray          *observers;
@property   (retain)    NSMutableDictionary     *_byCid;
@property   (retain)    NSMutableDictionary     *_byId;

- (id)      initWithModels:(id) models;
- (id)      initWithModels:(id) models andOptions:(NSDictionary*) options;
- (void)    initializeWithModels:(id) models andOptions:(NSDictionary*) options;


- (void)    resetWithModels:(id) _models;
- (void)    resetWithModels:(id) models andOptions:(NSDictionary*) options;

- (Class) modelClass;
- (void) change:(NSDictionary*) options;
- (NSMutableArray*) parse:(NSData*) data;
- (void) fetch:(NSDictionary*) _options;

- (NSString*) url;
- (NSString*) baseUrl;
- (void) setBaseUrl:(NSString*) _url;
+ (void) setBaseUrl:(NSString*) _url;


+ (Class) syncClass;

- (ISModel*) first;
- (ISModel*) last;
- (ISCollection*) add:(id) _models withOptions:(NSDictionary*) options;
- (ISModel*) byCid:(id) cid;
- (ISModel*) get:(id) id;
- (ISCollection*) add:(id) _models;
- (ISModel*) at:(NSInteger) index;
- (NSInteger) length;
- (ISCollection*) remove:(id) models;
- (ISCollection*) remove:(id) models withOptions:(NSDictionary*) options;
- (ISModel*) createModel:(id) model;
- (ISModel*) createModel:(id) model withOptions:(NSDictionary*) options;

@end

extern NSString* const  ADD_OR_RESET_KEY;
extern NSString* const  AT_KEY;