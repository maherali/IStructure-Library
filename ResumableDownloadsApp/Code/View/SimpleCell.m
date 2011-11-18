#import "SimpleCell.h"
#import "MyModel.h"

@implementation SimpleCell

@synthesize playPauseButton, model, observers, messageLabel;

- (void) configureCellWithModel:(MyModel*) _model{
    if(!self.observers){
        self.observers  =   $marray();
    }
    self.model  =   _model;
    if([self.model resourceExist]){
        hideLoadingPause = YES;
    }else{
        hideLoadingPause = NO;
    }
    currentlyPlaying = NO;
    if(hideLoadingPause){
        playPauseButton.hidden = YES;
    }else{
        playPauseButton.hidden = NO;
    }  
    __block SimpleCell *this = self;
    $unwatch(@"testing");

    $watch(@"percentage_retrieved", self.model, ^(NSNotification *notif){
        NSString *percentageSoFar = [notif.userInfo objectForKey:@"value"];
        this.messageLabel.text = $sprintf(@"%.0f%%", [percentageSoFar floatValue]);
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
    [super dealloc];
}

@end
