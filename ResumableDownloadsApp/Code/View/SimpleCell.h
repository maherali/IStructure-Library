@class MyModel;

@interface SimpleCell : UITableViewCell{
    IBOutlet UIButton           *playPauseButton;
    MyModel                     *model;
    NSMutableArray              *observers;
    IBOutlet UILabel            *messageLabel;
    IBOutlet UIProgressView     *progressView;
}

@property (nonatomic, retain) UIButton          *playPauseButton;
@property (nonatomic, retain) MyModel           *model;
@property (nonatomic, retain) NSMutableArray    *observers;
@property (nonatomic, retain) UILabel           *messageLabel;
@property (nonatomic, retain) UIProgressView    *progressView;


-(IBAction)playPauseTapped:(id)sender;
- (void) configureCellWithModel:(MyModel*) model;

@end
