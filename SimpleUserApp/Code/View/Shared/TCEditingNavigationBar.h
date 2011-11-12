@protocol TCEditingNavigationBarDelegate
- (void) moveToPrevious;
- (void) moveToNext;
- (void) done;
@end

@interface TCEditingNavigationBar : UIView{
    UIToolbar                           *keyboardToolbar;
    UISegmentedControl                  *nextPreviousControl;  
    id<TCEditingNavigationBarDelegate>  delegate;
}

@property (nonatomic, retain)   UIToolbar                           *keyboardToolbar;
@property (nonatomic, retain)   UISegmentedControl                  *nextPreviousControl;
@property (nonatomic, assign)   id<TCEditingNavigationBarDelegate>  delegate;

- (void) moveToNext;
- (void) moveToPrevious;

@end
