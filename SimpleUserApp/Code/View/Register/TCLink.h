#import "TCLinkLabel.h"

@interface TCLink : TCLinkLabel {
	UIColor     *tempColor;
}

+ (TCLink*) linkWithLabel:(NSString*) lbl;

extern NSString* const  TCLinkEventMame;

@end
