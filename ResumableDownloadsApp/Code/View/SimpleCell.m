#import "SimpleCell.h"
#import "MyModel.h"

@implementation SimpleCell

@synthesize playPauseButton, model;



- (void) configureCellWithModel:(MyModel*) _model{
    self.model  =   _model;
    if([self.model resourceExist]){
        LOG(@"resource exists!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }else{
        LOG(@"resource does not exist!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
    currentlyPlaying = NO;
}

- (IBAction) playPauseTapped:(id)sender{
    __block SimpleCell *this = self;
    if(currentlyPlaying){
        [sender setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = NO;
        $trigger(@"stop_loading", $dict(MODEL_KEY, model));
    }else{
        [sender setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = YES;
        $trigger(@"resume_loading", $dict(MODEL_KEY, model));
    }
}

-  (void) dealloc{
    self.model              =   nil;
    self.playPauseButton    =   nil;
    [super dealloc];
}

@end
