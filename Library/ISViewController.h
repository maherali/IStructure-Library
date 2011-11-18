@interface ISViewController : UIViewController {
    NSMutableArray   *observers;
    NSDictionary     *options;
    NSDictionary     *params;
}

@property (retain) NSDictionary     *options;
@property (retain) NSDictionary     *params;

- (id)              initWithValues:(NSDictionary*) _passedIn;
- (id)              initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary*) _passedInValues;
- (NSDictionary*)   routes;

@end
