#import "ISRouter.h"

@interface ISGenericController : UIViewController {
    NSMutableArray   *observers;
    NSDictionary     *options;
    NSDictionary     *params;
}

@property (retain) NSMutableArray   *observers;
@property (retain) NSDictionary     *options;
@property (retain) NSDictionary     *params;

- (id) initWithValues:(NSDictionary*) _passedIn;
- (NSDictionary*) routes;

@end
