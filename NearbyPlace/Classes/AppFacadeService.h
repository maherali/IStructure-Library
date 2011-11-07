#import "ISGenericController.h"

@interface AppFacadeService : NSObject{
    NSMutableArray          *observers;
    UINavigationController  *navigationController;
}

@property (nonatomic, retain)   NSMutableArray              *observers;
@property (nonatomic, retain)   UINavigationController      *navigationController;

@end
