#import "PlacesController.h"
#import "Places.h"
#import "Places2.h"

#define COLLECTION_CLASS Places2

@implementation PlacesController

- (id) initWithValues:(NSDictionary*) passedInValues{
    self = [super initWithValues:passedInValues andStyle:UITableViewStylePlain];
    self.collection = [[[COLLECTION_CLASS alloc] initWithModels:nil] autorelease]; 
    [self.collection fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(Places *newCollection, NSData *data){
    }), FAILURE_HANDLER_KEY, $block(^(Places *newCollection, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
    self.title = @"Nearby Places";
    return self;
}

@end
