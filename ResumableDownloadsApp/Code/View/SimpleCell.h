@class MyModel;

@interface SimpleCell : UITableViewCell{
    IBOutlet UIButton   *playPauseButton;
    BOOL                currentlyPlaying;
    MyModel             *model;
    BOOL                hideLoadingPause;
    NSMutableArray      *observers;
    IBOutlet UILabel    *messageLabel;
}

@property (nonatomic, retain) UIButton          *playPauseButton;
@property (nonatomic, retain) MyModel           *model;
@property (nonatomic, retain) NSMutableArray    *observers;
@property (nonatomic, retain) UILabel           *messageLabel;


-(IBAction)playPauseTapped:(id)sender;

- (void) configureCellWithModel:(MyModel*) model;

@end
