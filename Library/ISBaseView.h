@interface ISBaseView : UIView{
    ISModel                 *model;
    NSMutableArray          *observers;
}

/** The model attached to the view
 */
@property (nonatomic, assign) ISModel   *model;


@end
