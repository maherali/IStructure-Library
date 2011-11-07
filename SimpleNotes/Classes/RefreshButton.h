@interface RefreshButton : UIBarButtonItem {
    NSMutableArray      *observers;
}

@property (retain) NSMutableArray   *observers;

+ (RefreshButton*) buttonForCollection:(ISCollection*) collection target:(id) target andAction:(SEL) action;

@end
