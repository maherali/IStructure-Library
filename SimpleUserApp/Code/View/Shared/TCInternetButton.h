@interface TCInternetButton : UIButton {
    NSMutableArray      *observers;
}

@property (retain) NSMutableArray   *observers;

+ (TCInternetButton*) buttonForObservable:(id) observable target:(id) target action:(SEL) action frame:(CGRect) frame andLabel:(NSString*) label;
- (id) initWithObservable:(id) observable target:(id) target action:(SEL) action frame:(CGRect) frame andLabel:(NSString*) label;

@end
