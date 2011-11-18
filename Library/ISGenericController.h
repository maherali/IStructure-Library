@interface ISGenericController : NSObject {
    NSMutableArray   *observers;
    NSDictionary     *options;
    NSDictionary     *params;
}

@property (retain) NSDictionary     *options;
@property (retain) NSDictionary     *params;

- (id) initWithValues:(NSDictionary*) _passedIn;
- (NSDictionary*) routes;

@end
