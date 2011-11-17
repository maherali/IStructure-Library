@class MyModel;

@interface SimpleCell : UITableViewCell{
    IBOutlet UIButton   *playPauseButton;
    BOOL                currentlyPlaying;
    MyModel             *model;
}

@property (nonatomic, retain) UIButton   *playPauseButton;
@property (nonatomic, retain) MyModel    *model;


-(IBAction)playPauseTapped:(id)sender;

- (void) configureCellWithModel:(MyModel*) model;

@end
