/** ISModel class is the base class of the Model component of iStructure framework.
 
 A model has attributes and these attributes can be set directly or by synching with 
 a server. Other objects can observer a model and react to change events.
 
 A model can, and usually does, belong to a collection. 
*/

@class ISCollection;
@class ISBasicSync;

typedef void(^ValidationErrorHandler)(id origin, NSArray *errors, NSDictionary* options);

typedef void(^SuccessHandler)(id model, NSData *data);
typedef void(^ErrorHandler)(id model, NSArray *errors);
typedef void(^CancelHandler)(id model, NSArray *errors);

@interface ISModel : NSObject{
    NSString                *modelBaseUrl;
    NSMutableArray          *observers;
@protected
    BOOL                    _changed;
    BOOL                    _changing;
    
}
#pragma mark 
#pragma mark PROPERTIES

/** The identifier of the model instance.
 
 This value is obtained when the model instance is synchronized with the server and
 assumed to be unique in its class.
 */
@property   (retain) NSString               *id;

/** The client ID of the instance.
 
 This value is autogenerated and is unique in all iStructure objects.
 */
@property   (retain) NSString               *cid;

/** The collection of the model instance.
 
 A model instance can belong to at most one collection. When this value 
 is set, the model instance is tied to a collection.
 */
@property   (retain) ISCollection           *collection;

/** The synchronization property.
 
 During Fetch, Save, and Destroy, this synchronization instance is used to communicate with the server.
 
 */
@property   (retain) ISBasicSync            *sync;

#pragma mark

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
 
 
 The following show that a cid value is assigned after initialization:
 
    ISModel *aModel = [[[ISModel alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    STAssertNotNil(aModel.cid, @"Model: model should have a value for cid");

After initialization, the model is new:
 
    ISModel *aModel = [[[ISModel alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    STAssertTrue([aModel isNew], @"Model: model should be new after initalization");


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
/** Sets the attributes of the model with additional values.
 
 Invokes set:withOptions: passing *nil* for options.
 Every attribute in attr that exists in attributes is overwritten. 
 Attributes not found in `attrs` are not touched.

 @return The same ISModel instance. 
 @param attrs The key/value dictionary used to update the attributes.
 
 */
- (ISModel*) set:(NSDictionary*) attrs;

/** Sets the attributes of the model with additional values.

 Every attribute in `attr` that exists in attributes is overwritten. 
 Attributes not found in `attrs` are not touched.
 
 The following shows hwo to set the `name` attribute to an empty string.
 
    [model set:$dict(@"name", @"") withOptions:$dict()];
    STAssertEqualObjects([model get:@"name"], @"", @"Model: name is set correctly with empty string");
 
 The following shows how the `options` parameter is used to set the collection value of the model instance:
 
    ISCollection *collection = [[[ISCollection alloc] initWithModels:$array() andOptions:$dict()] autorelease];
    ISModel *aModel = [[[ISModel alloc] initWithAttributes:$dict() andOptions:$dict(COLLECTION_KEY, collection)] autorelease];
    STAssertEqualObjects(collection, aModel.collection, @"Model: collection should be stored correctly");

 Every attribute in attributes is mutable:
 
    ISModel *aModel = [[[ISModel alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    [aModel set:$dict(@"people", $array()) withOptions:$dict()];
    NSMutableArray    *people = [aModel get:@"people"];
    STAssertNotNil(people, @"Model: model should have a value for people attribute");
    [people addObject:@"Maher"];
    STAssertTrue(people.count == 1, @"Model: people attribute should be a mutable array");

 
 @return The same ISModel instance. 
 @param attrs The key/value dictionary used to update the attributes.
 @param options The options to control setting the atributes.
*/
- (ISModel*) set:(NSDictionary*) attrs withOptions:(NSDictionary*) options;

/** Remove a specific attribute from attributes.
 
 Invokes unSet:withOptions: passing *nil* as options.
 
 @return The instance itself.
 @param attr The attribute to be removed.
 */
- (ISModel*) unSet:(NSString*) attr;


/** Remove a specific attribute from attributes.
  
 @return The instance itself.
 @param attr The attribute to be removed.
 @param options The options to be used during the removal process.
 */
- (ISModel*) unSet:(NSString*) attr withOptions:(NSDictionary*) options;

/** Clears all the attributes.
 
 @return The instance itself.
 @param options The options used during the clearing process.
 */
- (ISModel*) clear:(NSDictionary*) options;


/** Checks to see if attributes has a specifc attribute.
 
 @return YES if the `attr` exists in attributes.
 @param attr The attribute to check.
 */
- (BOOL)     has:(NSString*) attr;


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
 
 
 @param data the raw data to be parsed.
 @param options the options for parsing.
*/

- (NSMutableDictionary*) parse:(NSData*) data withOptions:(NSMutableDictionary*) options;

/** Parses the raw data into attributes to be set on the model instance.

 Calls parse:withOptions: with options = $dict()
 
*/
- (NSMutableDictionary*) parse:(NSData*) data;


/** Obtain the value for a given attribute.
 
 Looks in the attributes dictionary and returns the value stored for _attr_ key.
 For example, to obtain the `title` of a note in an instance `note`, use `[note get:@"title"]`.
 
 @param attr Attribute you want to obtain its value.
*/
- (id) get:(NSString*) attr;

#pragma mark
#pragma mark URLs and PATHs

/** Specifies the root PATH of the model.
 
 The ISModel implementation returns *nil*.
 @return Root PATH.
 */
- (NSString*) pathRoot;


/** The PATH used to synchronize this model with the server.
 
 For a model that is server-backed, it needs to provide a URL value. The path method, by default, looks to see if 
 the model is inside a collection, if that's the case and the model is new, the collection's path becomes the Path value. 
 If there is a collection and the model is not new, the collection's path and the encoded value of the model's id value
 becomes the model's path. For example `/notes/1` is the path value returned where `/notes` is the collection's path 
 and `1` is the `id` value of the model instance. 
 
 
 If the model does not belong to a collection, then the value of its pathRoot method is substituted and used as above
 instead of the collection's path. Otherwise, an exception is thrown.
 
 
 For the complete URL to be used in accessing the server-backed version of the model instance, a base URL is prepended.
 This base URL can be empty (provided the URL value calculated above is sufficient) or it can be something else.
 The value of the base URL is provided by the baseUrl instance method of the model. The default, it returns the collection's 
 [ISCollection baseUrl]. If the model does not have a collection, it looks to see if the model's instance has one stored
 in its modelBaseUrl instance variable and returns it. If not, it looks for it in the model's class \_baseUrl static value.
 You can set the instance value using the setBaseUrl: instance method. You can set the class \_baseUrl using the setBaseUrl:
 class method.
 
 
 In addtion, you can provide fine-grained model paths for the four different synchronization methods by overriding the
 following methods: fetchPath, createPath, updatePath, and destroyPath.
 
 
 If an operation (such as Fetch) is invoked on the instance and the corresponding path method (e.g., fetchpath) does not
 return *nil*, the value returned is used instead of the value returned from the path instance method.
 The base URL is calculated as normal.
 
 @return The path value of this instance.
 */
- (NSString*) path;

/** The fetch path used in a Fetch operation.
 
 @return the path value used in a Fetch operation.
 Base implementation returns *nil*.
 */
- (NSString*) fetchPath;

/** The create path used in a Save operation.
 
 @return the path value used in a Save operation.
 Base implementation returns *nil*.
 */
- (NSString*) createPath;


/** The create path used in a Save operation of a model with id equals to *nil*.
 
 @return the path value used in a Save operation.
 Base implementation returns *nil*.
 */
- (NSString*) updatePath;

/** The create path used in a Destroy operation with a non-*nil* id.
 
 @return the path value used in a Destroy operation.
 Base implementation returns *nil*.
 */
- (NSString*) destroyPath;


/** The Base URL of the ISModel instance.
 
 @return The Base URL part of the model's URL.
 
 The default behavior is to return the Base URL of the collection if the model has a collection. 
 Otherwise, the model's   modelBaseUrl   instance variable is returned if set. If not, the class' \_baseUrl
 is returned if it's set. Otherwise, an empty string is returned. The following shows the 
 default implementation of the ISModel class:
 
    if(self.collection){
        return [self.collection baseUrl];
    }else{
        return modelBaseUrl ? modelBaseUrl : _baseUrl ? _baseUrl : @"";
    }
 
 */
- (NSString*) baseUrl;

/** Set the Base URL of the model instance.

 Used to provide a Base URL of the instance that will be used when server is contacted. 

 @param theUrl The URL value to be set as Base URL of the model instance.
*/
- (void) setBaseUrl:(NSString*) theUrl;


/** Set the Base URL of the model class.
 
 Used to provide a Base URL of the model class that will be used when server is contacted.
 
 @param theUrl The URL value to be set as Base URL of the model class.
 */
+ (void) setBaseUrl:(NSString*) theUrl;


#pragma mark
#pragma mark CHANGE
/**
*/
- (BOOL) hasChanged:(NSString*) attr;

/**
 */
- (NSArray*) changedAttributes:(NSDictionary*) now;

/** The previous value of an attribute
 
 @return The value of the attribute, nil if not found.
 @param  attr The attribute key.
*/
- (id) previous:(NSString*) attr;

/** The previous attributes.
 
 @return A dictionary of the previous attributes.
*/
- (NSMutableDictionary*) previousAttributes;

/** The changed attributes.
 
 @return An array of attribute names whose values have changed.
*/
- (NSArray*) changedAttributes;

/** Has the model instance changed.
 
 @return YES if the model instance has any attribute whose value has changed.
*/
- (BOOL) hasChanged;

/** Force a change event on the model.
 
 Call changeWithOptions: with `options` as *nil*.
*/
- (void) change;

/** Force a change event on the model
 
 Triggers a `@"change"` event with passing the `options` in the `OPTIONS_KEY` key.
 
 @param options The options for this call.
*/
- (void) changeWithOptions:(NSDictionary*) options;

#pragma mark
#pragma mark SYNC

/** Fetches the model from the server.
 
 To fetch a model instance is to go to the server and retrieve the attributes and set them on the model instance.
 Fetch uses an optional `options` parameter. 
 
 The following options can be used:
 
 1. `SUCCESS_HANDLER_KEY`. This is a block of type `SuccessHandler` to be invoked when the retrieval of the model 
 is successful. `SuccessHandler` is declared as follows:
 
    
        typedef void(^SuccessHandler)(id model, NSData *data);
 
 
 2. `FAILURE_HANDLER_KEY`. This is a block of type `ErrorHandler` to be invoked when the retrieval of the model fails. 
 `ErrorHandler` is declared as follows:
 
        typedef void(^ErrorHandler)(id model, NSArray *errors);
 
 
 After contacting the server, the error handler is invoked in the case of having network or  app erros.
 An example of a network error is if the server is down. Models can define their own app errors in their customized Sync class. 
 If there is an error and the error handler is not specified, an `@"error"` event is triggered by the model.
 
 
 A model specifies a Sync class that is instantiated when the model is synchronized. This is done in the `syncClass` class
 method. The ISModel class defines it as follows:
 
    + (Class) syncClass{
        return [ISBasicSync class];
    }
 
 See ISSync and ISBasicSync for more information.
 
 In the case that the network communication is successful and there are no network errors, the parse: method of the model is called 
 passing in the raw data received by from the server. The base implementation assumes that  the data is in JSON format and it is a hash, 
 so it parses it and generates a mutable dictionary of it as follows:
 
    - (NSMutableDictionary*) parse:(NSData*) data{
        return [[[[SBJsonParser alloc] init] autorelease] objectWithData:data];
    }
 
 For most applications (such as those created using Rails 3.1), this si sufficient. If that is not the case, you can override 
 this method and parse it as you like. See the NearbyPlace example for parsing XML. Whatever is returned from the parse method 
 is used to set the attributes of the model instance. You can always return empty dictionary and use the data returned from the 
 server to update the model according to your pleasing (e.g., update model associations, etc.)
 The `parse:` message is always sent on a different thread than the Main Thread. This offloads heavy parsing from the UI thread. 
 
 @param options The options if any.
*/
- (void) fetch:(NSDictionary*) options;

/**
 
 @param options The options if any
 */
- (void) destroy:(NSDictionary*) options;

/** Save a model to the server.
 
 Invokes save:options: passing *nil* for the `attrs` parameter.
 
 @param options The options if any.
 */
- (void) save:(NSDictionary*) options;


/** Save a model to the server.
 
 Save works in the same way as fetch except the method `dataToSave` of the model is called to provide the data 
 (instance of `NSData`) that will be sent to the server. By default the data is a JSON representation of the attributes 
 obtained by sending a JSONDataFromAttributes: message to the model instance passing in `attributes` as an argument. 
 Override this method in your base class if this is not the behavior that you wish. See SimplePhotos sample app.
 
 Save is used for both saving an existing (non-new) model as well as creating a new object.

 @param attrs The attributes to be set before saving the model.
 @param options The options, if any.
 */

- (void) save:(NSDictionary *) attrs options:(NSDictionary*) options;

/** The synchronization class.
 
 Default ISModel returns ISBasicSync for JSON over HTTP.
 @return a class of type ISSync.
 */
+ (Class) syncClass;

/** Data to send to the server during save operation.
 
 Default implementation is to return an `NSData` instance from the JSON representation of the attributes dictionary.
 @return An `NSData` instance representign the raw data. 
 */
- (NSData*) dataToSave;

/** Obtain a raw data of teh JSON representation of a set of attributes
 
 @return The raw `NSData` representation.
 @param attrs The attributes you want to obtain raw data from.
 
 */
- (NSData*) JSONDataFromAttributes:(NSDictionary*) attrs;

#pragma mark

/** Performs validations on a set of attributes.
 
 You can pass in the `options` an validation error block of type `ValidationErrorHandler` using the
 `VALIDATION_ERROR_HANDLER_KEY` key.
 
 A `validate:` message is sent to the model instance passing in the `attrs` parameter.
 If the return value of `validate:` has one or more elements (errors) and the validation error block 
 is not *nil*, the validation error block is 
 invoked passing the value of *self*, the errors array, and the `options`.
 Otherwise, an `@"error"` is triggered passing the errors, the `options`, and the model's collection, if it has one.
 
 @return YES if the validation is successful.
 @param attrs The attributes to validate.
 @param option The options to be used in the validation.
 */
- (BOOL) performValidation:(NSDictionary*) attrs withOptions:(NSDictionary*) options;

/** Perform last minute changes to the options hash sent by the model during read, update, delete, and create
 
 @param opts The options to be sent to the sync to perform method operation
 @param method The operation being performed. Can be METHOD_READ, METHOD_UPDATE, METHOD_DELETE, METHOD_CREATE.
 
 */
- (void) lastChanceToUpdateSyncOptions:(NSMutableDictionary*) opts forMethod:(NSString*) method;

/**
 Cancel the currently ongoing sync operation.
 */
- (void) cancel;

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
extern NSString* const  CANCEL_HANDLER_KEY;



