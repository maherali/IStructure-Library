#import "SimpleCell.h"
#import "MyModel.h"

@implementation SimpleCell

@synthesize playPauseButton, model, observers, messageLabel, progressView;

- (void) configureCellWithModel:(MyModel*) _model{
    if(!self.observers){
        self.observers  =   $marray();
    }
    __block SimpleCell *this = self;
    if(this.model){
        $unwatch(@"percentage_retrieved", this.model);
    }
    $watch(@"percentage_retrieved", _model, ^(NSNotification *notif){
        NSString *percentageSoFar = [notif.userInfo objectForKey:@"value"];
        this.messageLabel.text = $sprintf(@"%.0f%%", [percentageSoFar floatValue]);
        this.progressView.progress = [percentageSoFar floatValue]/100.0f;
    });
    self.model  =   _model;
    self.messageLabel.text = @"";
    if([self.model resourceExist]){
        playPauseButton.hidden = YES;
        self.progressView.progress = 1.0f;
    }else{
        playPauseButton.hidden = NO;
        self.progressView.progress = model.percentage/100.0f;
    }
    if(self.model.downloadOngoing){
        [playPauseButton setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
    }
    if(self.model.downloadPaused){
        [playPauseButton setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
    }
    if(!self.model.downloadOngoing && ! self.model.downloadPaused){
        [playPauseButton setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
    }
}

- (IBAction) playPauseTapped:(id)sender{
    __block SimpleCell *this = self;
    if(self.model.downloadPaused || (!self.model.downloadOngoing && !self.model.downloadPaused)){
        self.model.downloadOngoing = YES;
        self.model.downloadPaused  = NO;
         [sender setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
        $trigger(@"resume_loading", $dict(MODEL_KEY, self.model));
    }else if(self.model.downloadOngoing){
        [sender setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
        self.model.downloadOngoing = NO;
        self.model.downloadPaused  = YES;
        $trigger(@"stop_loading", $dict(MODEL_KEY, self.model));
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
