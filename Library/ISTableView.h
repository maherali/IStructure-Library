@class ISModel;
@class ISCollection;

@interface ISTableView : UITableView<UITableViewDelegate, UITableViewDataSource>{
    ISModel             *model;
    ISCollection        *collection;
    NSDictionary        *options;
    NSMutableArray      *observers;
}

@property (retain) NSMutableArray   *observers;

/** The model attached to the tableview
 */
@property (retain) ISModel          *model;

/** The collection attached to the tableview
 */
@property (retain) ISCollection     *collection;

/** The options used in the initialization of the tableview.
 */
@property (retain) NSDictionary     *options;

/** Initialize the instance of the tableview.
 
 Invokes the initWithOptions:andStyle: method passing `UITableViewStyleGrouped` as a style.
 
 @param options The options used in the initialization of the tableview.
*/
- (id) initWithOptions:(NSDictionary*) options;


/**  Initialize the instance of the tableview.

 Pass in value for the `MODEL_KEY` key in options to specify the model attached to the view.
 Pass in value for the `COLLECTION_KEY` key in options to specify the collection attached to the view.
 Usually, you pass in either a model or a collection. A collection have precedence in populating and controlling 
 the appearance of the tableview.
 
 @param options The options used in the initialization of the tableview.
 @param style The style of the tableview.
*/
- (id) initWithOptions:(NSDictionary*) options andStyle:(UITableViewStyle) style;

@end
