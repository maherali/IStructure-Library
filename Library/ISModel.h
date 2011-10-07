/** ISModel class is the base class of the Model component of iStructure framework. 
*/

@class ISCollection;
@class ISBasicSync;

typedef void(^ValidationErrorHandler)(id origin, NSArray *errors, NSDictionary* options);

typedef void(^SuccessHandler)(id model, NSData *data);
typedef void(^ErrorHandler)(id model, NSArray *errors);


@interface ISModel : NSObject{
    NSString                *modelBaseUrl;
    NSMutableArray          *observers;
}
#pragma mark 
#pragma mark PROPERTIES
@property   (retain) NSMutableArray         *observers;
@property   (retain) NSMutableDictionary    *attributes;
@property   (retain) NSString               *id;
@property   (retain) NSString               *cid;
@property   (retain) ISCollection           *collection;
@property   (retain) ISBasicSync                 *sync;

#pragma mark
@property   (retain) NSMutableDictionary    *_previousAttributes;
@property   (assign) BOOL                   _changed;
@property   (assign) BOOL                   _changing;

#pragma mark
#pragma mark INIT

/** Initilizes the model instance.
 
 During initialization ...
 
 @param attrs attributes that you wish to add to the new instance
 @param options the options used during initialization

 
 */
- (id)   initWithAttributes:(NSDictionary*) attrs andOptions:(NSDictionary*) options;

/** A chance for subclasses to initialize themselves
 
 At the end of the  initWithAttributes:andOptions: method, it call this method giving a chance 
 to subclasses to initialize themselves. ISModel implementation is a noop.
 
 @param attrs the attributes used during the initWithAttributes:andOptions: call
 @param options the options used during the initWithAttributes:andOptions: call

*/
- (void) initializeWithAttributes:(NSDictionary*) attrs andOptions:(NSDictionary*) options;

#pragma mark
#pragma mark Model
/** Indicates wheather the model instance is new or not.
 
 A new model instance is one whose id is nil. Saving a new model
 to the server will result in a post while saving a non-new model
 will result in an update.

*/
- (BOOL) isNew;

/** Specifies the name of the id attribute of the model.
 
 By default, the method returns @"id". Override this method to 
 specify different behavior.
*/
- (NSString*) idAttribute;

#pragma mark
#pragma mark ATTRIBUTES
- (ISModel*) set:(NSDictionary*) attrs;
- (ISModel*) set:(NSDictionary*) attrs withOptions:(NSDictionary*) options;
- (ISModel*) unSet:(NSString*) attr;
- (ISModel*) unSet:(NSString*) attr withOptions:(NSDictionary*) options;
- (ISModel*) clear:(NSDictionary*) options;
- (BOOL)         has:(NSString*) attr;

/** Specifies the default attributes.
 
 By default, this method returns nil. Override this method to 
 provide attributes that get set on a newly created model instance.
*/
- (NSDictionary*) defaults;

/** Parses the raw data from the server into attributes to be set on the model instance.
 
 
 After obtaining the server's response, the data needs to be parsed into a dictionary 
 of attributes and these attributes are set on the model. The default behavior assumes that the
 server's response is a JSON hash. Override this method to specify different behavior.
 You can also return nil and use the data to decorate your instance. 
 
 
 @param data the raw data obtained from the server to be parsed.
*/
- (NSMutableDictionary*) parse:(NSData*) data;


/** Obtain the value for a given attribute.
 
 Looks in the attributes and returns the value stored for attr.
 For example, to obtain the title of a note, use [note get:@"title"]
 
 @param attr the attribute you want to obtain its value
*/
- (id) get:(NSString*) attr;

#pragma mark
#pragma mark URLS
- (NSString*) urlRoot;
- (NSString*) url;
- (NSString*) fetchUrl;
- (NSString*) createUrl;
- (NSString*) updateUrl;
- (NSString*) destroyUrl;

- (NSString*) baseUrl;
- (void) setBaseUrl:(NSString*) _url;
+ (void) setBaseUrl:(NSString*) _url;

#pragma mark
#pragma mark CHANGE
- (BOOL) hasChanged:(NSString*) attr;
- (NSArray*) changedAttributes:(NSDictionary*) now;
- (id) previous:(NSString*) attr;
- (NSMutableDictionary*) previousAttributes;
- (NSArray*) changedAttributes;
- (BOOL) hasChanged;
- (void) change;
- (void) changeWithOptions:(NSDictionary*) options;

#pragma mark
#pragma mark SYNC
- (void) fetch:(NSDictionary*) options;
- (void) destroy:(NSDictionary*) _options;
- (void) save:(NSDictionary*) _options;
- (void) save:(NSDictionary *) attrs options:(NSDictionary*) _options;
+ (Class) syncClass;
- (NSData*) dataToSave;
- (NSData*) JSONDataFromAttributes:(NSDictionary*) attrs;

#pragma mark
#pragma mark INTERNAL

- (BOOL) _performValidation:(NSDictionary*) attrs withOptions:(NSDictionary*) options;

@end

extern NSString* const  MODEL_KEY;
extern NSString* const  COLLECTION_KEY;
extern NSString* const  SILENT_KEY;
extern NSString* const  VALIDATION_ERROR_HANDLER_KEY;
extern NSString* const  ERRORS_KEY;
extern NSString* const  SENDER_KEY;
extern NSString* const  VALUE_KEY;
extern NSString* const  OPTIONS_KEY;
extern NSString* const  PARAMS_KEY;
extern NSString* const  SUCCESS_HANDLER_KEY;
extern NSString* const  FAILURE_HANDLER_KEY;






