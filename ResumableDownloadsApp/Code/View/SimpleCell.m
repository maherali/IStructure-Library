#import "SimpleCell.h"
#import "MyModel.h"

@implementation SimpleCell

@synthesize playPauseButton, model, observers, messageLabel, progressView;

- (void) configureCellWithModel:(MyModel*) _model{
    if(!self.observers){
        self.observers  =   $marray();
    }
    self.model  =   _model;
    self.messageLabel.text = @"";
    if([self.model resourceExist]){
        hideLoadingPause = YES;
        self.progressView.progress = 1.0f;
    }else{
        hideLoadingPause = NO;
        self.progressView.progress = model.percentage/100.0f;
    }
    currentlyPlaying = NO;
    if(hideLoadingPause){
        playPauseButton.hidden = YES;
    }else{
        playPauseButton.hidden = NO;
    }  
    if(!currentlyPlaying){
        [playPauseButton setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
    }else{
        [playPauseButton setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
    }
    __block SimpleCell *this = self;
    $unwatch(@"percentage_retrieved");
    $unwatch(@"change");
    $watch(@"percentage_retrieved", self.model, ^(NSNotification *notif){
        NSString *percentageSoFar = [notif.userInfo objectForKey:@"value"];
        this.messageLabel.text = $sprintf(@"%.0f%%", [percentageSoFar floatValue]);
        this.progressView.progress = [percentageSoFar floatValue]/100.0f;
    });
    $watch(@"change", self.model, ^(NSNotification *notif){
        [this configureCellWithModel:this.model];
    });
}

- (IBAction) playPauseTapped:(id)sender{
    __block SimpleCell *this = self;
    if(currentlyPlaying){
        [sender setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = NO;
        $trigger(@"stop_loading");
    }else{
        [sender setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = YES;
        $trigger(@"resume_loading");
    }
}

-  (void) dealloc{
    __block SimpleCell *this = self;
    $unwatch();
    self.observers          =   nil;
    self.model              =   nil;
    self.playPauseButton    =   nil;
    self.messageLabel       =   nil;
    self.progressView       =   nil;
    [super dealloc];
}

@end
