#import "TCWebHostView.h"
#import "ISViewController.h"

@interface TCWebHostController :  ISViewController {
    TCWebHostView                       *mainView;
	NSString                            *url;
    BOOL                                donotScale;
}

@property   (nonatomic, retain) TCWebHostView                  *mainView;
@property   (nonatomic, copy)   NSString                       *url;
@property   (nonatomic, assign) BOOL                           donotScale;

@end

