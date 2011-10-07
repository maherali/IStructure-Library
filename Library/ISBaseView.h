@interface ISBaseView : UIView{
    ISModel                 *model;
    NSMutableArray          *observers;
}

@property (nonatomic, assign) ISModel               *model;
@property (nonatomic, retain) NSMutableArray        *observers;

@end
