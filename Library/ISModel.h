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

/** Initialize a new model instance. You call this method after allocating a new ISModel instance.
 
 First, a unique Client ID (cid) is assigned to the new instance. After that, 
 the defaults and _attrs_ parameter are set on the model's attributes with `SILENT_KEY` equal to `YES`. In addition, if
 a Collection is passed in the _options_ dictionary (using the key `COLLECTION_KEY`), it's assigned
 to the collection property. Finally, `initializeWithAttributes:andOptions:` message is sent to the 
 newly-created instance.
 
 
 The following shows an example:
 
 
    ISModel *aModel = [[[ISModel alloc] initWithAttributes:$dict(@"one", @"1") andOptions:$dict()] autorelease];
    STAssertTrue([aModel has:@"one"], @"Model: has a \"one\" attribute from initialization");
 
 
 @param attrs Attributes that you wish to add to the new instance.
 @param options The options used during initialization.

 
 */
- (id)   initWithAttributes:(NSDictionary*) attrs andOptions:(NSDictionary*) options;

/** A chance for subclasses to initialize themselves.
 
 
 At the end of the  initWithAttributes:andOptions: method, it calls this method giving a chance 
 to subclasses to initialize themselves. ISModel implementation is a noop.
 
 @param attrs Attributes used during the initWithAttributes:andOptions: call.
 @param options Options used during the initWithAttributes:andOptions: call.

*/
- (void) initializeWithAttributes:(NSDictionary*) attrs andOptions:(NSDictionary*) options;

#pragma mark
#pragma mark Model

/** Indicates Whether the model instance is new or not.
 
 A new model instance is one whose id is *nil*. Saving a new model
 to the server will result in a POST while saving a non-new model
 will result in an UPDATE.

*/
- (BOOL) isNew;

/** Specifies the name of the id attribute of the model.
 
 By default, the method returns `@"id"`. Override this method to 
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
 
 By default, this method returns *nil*. Override this method to 
 provide default values that get set on a newly created model instance.
*/
- (NSDictionary*) defaults;

/** Parses the raw data from the server into attributes to be set on the model instance.
 
 
 After obtaining the server's response, the data needs to be parsed into a dictionary 
 of attributes and these attributes are set on the model. The default behavior assumes that the
 server's response is a JSON hash. Override this method to specify different behavior.
 You can also return *nil* and use the data to decorate your instance. 
 
 
 @param data the raw data obtained from the server to be parsed.
*/
- (NSMutableDictionary*) parse:(NSData*) data;


/** Obtain the value for a given attribute.
 
 Looks in the attributes dictionary and returns the value stored for _attr_ key.
 For example, to obtain the `title` of a note in an instance `note`, use `[note get:@"title"]`.
 
 @param attr Attribute you want to obtain its value.
*/
- (id) get:(NSString*) attr;

#pragma mark
#pragma mark URLS

/** Specifies the root URL of the model.
 
 The ISModel implementation returns *nil*.
 @return Root URL.
 */
- (NSString*) urlRoot;


/** The URL used to synchronize this model with the server.
 
 For a model that is server-backed, it needs to provide a URL value. The url method, by default, looks to see if 
 the model is inside a collection, if that's the case and the model is new, the collection's URL becomes the URL value. 
 If there is a collection and the model is not new, the collection's URL and the encoded value of the model's id value
 becomes the model's url. For example `/notes/1` is the URL value returned where `/notes` is the collection's URL 
 and `1` is the `id` value of the model instance. 
 
 
 If the model does not belong to a collection, then the value of its urlRoot method is substituted and used as above
 instead of the collection's URL. Otherwise, an exception is thrown.
 
 
 For the complete URL to be used in accessing the server-backed version of the model instance, a base URL is prepended.
 This base URL can be empty (provided the URL value calculated above is sufficient) or it can be something else.
 The value of the base URL is provided by the baseUrl instance method of the model. The default, it returns the collection's 
 [ISCollection baseUrl]. If the model does not have a collection, it looks to see if the model's instance has one stored
 in its modelBaseUrl instance variable and returns it. If not, it looks for it in the model's class \_baseUrl static value.
 You can set the instance value using the setBaseUrl: instance method. You can set the class \_baseUrl using the setBaseUrl:
 class method.
 
 
 In addtion, you can provide fine-grained model URLs for the four different synchronization methods by overriding the
 following methods: fetchUrl, createUrl, updateUrl, destroyUrl.
 
 
 If an operation (such as Fetch) is invoked on the instance and the corresponding URL method (e.g., fetchUrl) does not
 return *nil*, the value returned is used instead of the value returned from the url instance method.
 The base URL is calculated as normal.
 
 @return The URL value of this instance.
 */
- (NSString*) url;

/** The fetch URL used in a Fetch operation.
 
 @return the URL value used in a Fetch operation.
 Base implementation returns *nil*.
 */
- (NSString*) fetchUrl;

/** The create URL used in a Save operation.
 
 @return the URL value used in a Save operation.
 Base implementation returns *nil*.
 */
- (NSString*) createUrl;


/** The create URL used in a Save operation of a model with id equals to *nil*.
 
 @return the URL value used in a Save operation.
 Base implementation returns *nil*.
 */
- (NSString*) updateUrl;

/** The create URL used in a Destroy operation with a non-*nil* id.
 
 @return the URL value used in a Destroy operation.
 Base implementation returns *nil*.
 */
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






