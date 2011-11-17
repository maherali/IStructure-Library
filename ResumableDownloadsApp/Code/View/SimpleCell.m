#import "SimpleCell.h"

@implementation SimpleCell


@synthesize playPauseButton;

- (void) configure{
    currentlyPlaying = NO;
}

-(IBAction)playPauseTapped:(id)sender{
    if(currentlyPlaying){
        [sender setImage:[UIImage imageNamed:@"play_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = NO;
    }else{
        [sender setImage:[UIImage imageNamed:@"pause_button_30.png"] forState:UIControlStateNormal];
        currentlyPlaying = YES;
    }
}

- (void) dealloc{
    self.playPauseButton    =   nil;
    [super dealloc];
}

@end
