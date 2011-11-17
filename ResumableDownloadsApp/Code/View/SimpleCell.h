@interface SimpleCell : UITableViewCell{
    IBOutlet UIButton   *playPauseButton;
    BOOL                currentlyPlaying;
}

@property (nonatomic, retain) UIButton   *playPauseButton;

-(IBAction)playPauseTapped:(id)sender;

- (void) configure;

@end
