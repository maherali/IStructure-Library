@interface ISCollection : NSObject{
    NSMutableArray          *observers;
     NSString               *collectionBaseUrl;
}

@property   (retain)    NSMutableArray          *models;
@property   (retain)    ISBasicSync             *sync;
@property   (retain)    NSMutableArray          *observers;
@property   (retain)    NSMutableDictionary     *_byCid;
@property   (retain)    NSMutableDictionary     *_byId;

/** Initialize with a set of models.
 
 Invokes initWithModels:andOptions: with *nil* options.
 @param models A model or an array of models to initialize the collection with.
*/
- (id)      initWithModels:(id) models;

/** Initialize the collection with a set of models using options.
 
 The `models` can be either an array of models, an array of dictionaries (attributes for each model), a model, 
 or a dictionary representing the attributes of a model.
 
 After `models` are added to the `models` internal array, a `reset` eent is triggered as follows:
 
    $trigger(@"reset", $dict(SENDER_KEY, self, OPTIONS_KEY, options, COLLECTION_KEY, self) );
 
 At the end, the message initializeWithModels:andOptions: is sent to the instance passing 
 in the `models` and `options` as parameters. The base class' implementation is a noop.
 
 @param models A model or an array of models to initialize the collection with.
 @param options The options used in the initialization.
*/
- (id)      initWithModels:(id) models andOptions:(NSDictionary*) options;

/** Initialize the collection.

 This is an oppertunity for the subclasses to do any custom initialization. Base class' implementation
 is a noop.
 
 @param models A model or an array of models to initialize the collection with.
 @param options The options used in the initialization.

*/
- (void)    initializeWithModels:(id) models andOptions:(NSDictionary*) options;

/** Resets the collection with a new set of models.

 Invokes resetWithModels:andOptions: with *nil* `options`.
 @param models The models to reset the collection with.
 */
- (void)    resetWithModels:(id) models;

/** Resets the collection with a new set of models.
 
 All exisitng models in the models array have references to the collection removed and 
 are then removed from the models array.
 
 If `SILENT_KEY` is not equal to YES, a `reset` event is triggered.
 
 @param models The models to reset the collection with.
 @param options The options to use in resetting the collection.
*/
- (void)    resetWithModels:(id) models andOptions:(NSDictionary*) options;

/** The model class used to instiantiate models when adding to the collection.
 
 When you pass in a dictionary or an array of dictionary to add to the collection,
 this class instantiated and the initialized by one of the dictionary objects.
 
 @return A class of type ISModel.
 */
- (Class) modelClass;


- (void) change:(NSDictionary*) options;

/** Parse the raw data from the server.
 
 @return An NSArray instance of the models parsed.
 @param data The raw data from server.
*/
- (NSMutableArray*) parse:(NSData*) data;

/** Fetch collection from the server.
 
 If you pass `YES` in the `ADD_OR_RESET_KEY` key, the models fetched will be added to the 
 collection. Not passing anything or passing `NO` will result in resetting the collection
 with the models fetched.
 
 @param options The options used in retrieving the collection from the server.
 */

- (void) fetch:(NSDictionary*) options;

/** The collection's URL
 
 @return The collections's URL.
 */
- (NSString*) url;

/** The base URL of the collection
@return The base URL of the collection
*/
- (NSString*) baseUrl;

/** Update the base URL of the collection instance.
 
 @param url The URL to update with.
*/
- (void) setBaseUrl:(NSString*) url;

/** Update the collection's class base URL.

 @param url The URL to update with.
*/
+ (void) setBaseUrl:(NSString*) url;


/** The synchronizagtion class for the collection.
 
 @return The class instantiated when the collection is synchronized.
*/
+ (Class) syncClass;

/** The first element in the collection.
 
 @return The ISModel instance that is first in the collection.
*/
- (ISModel*) first;

/** The last element in the collection.
 
 @return The ISModel instance that is last in the collection.
*/
- (ISModel*) last;

/** Add a set of models to the collection.
 
 Invokes add:withOptions: with `options` equal to *nil*.
 
 @return The collection instance.
 @param models The models to add to the collection.
*/

- (ISCollection*) add:(id) models;

/** Add a set of models to the collection.
 
 If `options` does not have a SILENT_KEY key with value `YES`, an `add` event is triggered as follows:
 
    $trigger(@"add", $dict(SENDER_KEY, model, OPTIONS_KEY, options, COLLECTION_KEY, self), model);
 
 Passing an index in the `AT_KEY` key  will result in adding the model at the index position. 
 Otherwise, the model is added at the end.
 
 @return The collection instance.
 @param models The models to add to the collection.
 @param options Options used to add models to the collection.
*/
- (ISCollection*) add:(id) models withOptions:(NSDictionary*) options;

/** Retrieves a model in the collection by its cid
 
 @return The ISModel instance or *nil* if not found.
 @param cid The cid of the model or an instance of ISModel.
 
*/
- (ISModel*) byCid:(id) cid;

/** Retrieves a model in the collection by its id
 
 @return The ISModel instance or *nil* if not found.
 @param id The id of the model or an instance of ISModel.
 
 */
- (ISModel*) get:(id) id;


/** Retrieves a model in the collection by its index
 
 @return The ISModel instance or *nil* if not found.
 @param index The index of the model in the collection.
 
 */
- (ISModel*) at:(NSInteger) index;

/** Retrieves the length of the collection
 
 @return The number of models in the collection.
*/
- (NSInteger) length;


/** Removes a model or a an array of models from the collection.
 
 Invokes remove:withOptions: with `options` equal to *nil*.
 @return The collection instance.
 @param models A NSArray of ISModel instance or an NSModel instance to be removed.
 */
- (ISCollection*) remove:(id) models;

/** Removes a model or a an array of models from the collection.
 
 If `SILENT_KEY` is not equal to `YES`, a `remove` event is triggered as follows:
 
    $trigger(@"remove", $dict(SENDER_KEY, model, COLLECTION_KEY, self, OPTIONS_KEY, $dict()), model);
 
 @return The collection instance.
 @param models A NSArray of ISModel instance or an NSModel instance to be removed.
 @param options Options used in removal process.
 */
- (ISCollection*) remove:(id) models withOptions:(NSDictionary*) options;


/** Creates a model and adds it to the collection.
 
 Invokes createModel:withOptions with `options` equal to *nil*.
 
 @return An ISModel instance if model was successfully created and added to the collection.
 @param model An instance of ISModel or a dictionary of attributes to be used to construct an ISModel instance.
 */
- (ISModel*) createModel:(id) model;

/** Creates a model and adds it to the collection.
 
 Passing a `SuccessHandler` block in `SUCCESS_HANDLER_KEY` will result in invoking the 
 block passing in the created model and the raw data obtained from server.
 
 Passing an `ErrorHandler` handler in `FAILURE_HANDLER_KEY` will result in invoking the block 
 passing in the model and an array of errors in the case of errors.
 
 @return An ISModel instance if model was successfully created and added to the collection.
 @param model An instance of ISModel or a dictionary of attributes to be used to construct an ISModel instance.
 @param options The options to be used during the creation of the model and adding it to the collection.
 */

- (ISModel*) createModel:(id) model withOptions:(NSDictionary*) options;

@end

extern NSString* const  ADD_OR_RESET_KEY;
extern NSString* const  AT_KEY;


























