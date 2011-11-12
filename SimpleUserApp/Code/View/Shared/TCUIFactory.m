#import "TCUIFactory.h"

@implementation TCUIFactory

+ (UIImageView*) backgroundImageView{
    UIImageView *imgView    = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    imgView.image           = [UIImage imageNamed:@"bg_main.png"];
    return imgView;
}

+ (UIBarButtonItem*) backButtonForTarget:(id) target andAction:(SEL) action{
    UIView *customView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 52, 30)] autorelease];
    UIButton *customButton = [[[UIButton alloc] initWithFrame:customView.frame] autorelease];
    [customButton setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"btn_back_press.png"] forState:UIControlStateHighlighted];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    return [[[UIBarButtonItem alloc] initWithCustomView:customView] autorelease];
}

+ (UIBarButtonItem*) editRefreshButtonsForTarget:(id) target editAction:(SEL) editAction refreshAction:(SEL) refreshAction{
    
    UIImage *editImg = [UIImage imageNamed:@"btn_edit.png"];
    
    UIView *customView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, editImg.size.width*2, 30)] autorelease];
    UIButton *editButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, editImg.size.width, 30)] autorelease];

    [editButton setImage:[UIImage imageNamed:@"btn_edit.png"] forState:UIControlStateNormal];
    [editButton setImage:[UIImage imageNamed:@"btn_edit_press.png"] forState:UIControlStateHighlighted];
    [editButton addTarget:target action:editAction forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:editButton];
    
    UIButton *refreshButton = [[[UIButton alloc] initWithFrame:CGRectMake(editImg.size.width, 0, editImg.size.width, 30)] autorelease];
    [refreshButton setImage:[UIImage imageNamed:@"btn_refresh.png"] forState:UIControlStateNormal];
    [refreshButton setImage:[UIImage imageNamed:@"btn_refresh_press.png"] forState:UIControlStateHighlighted];
    [refreshButton addTarget:target action:refreshAction forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:refreshButton];

    return [[[UIBarButtonItem alloc] initWithCustomView:customView] autorelease];
}


+(UIButton *)buttonWithLabel:(NSString *)label frame:(CGRect)frame {
	UIButton *button = [[[UIButton alloc] initWithFrame:frame] autorelease];
	button.tag = label.hash;
	[button setTitle:label forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:37/255.0f green:45/255.0f blue:52/255.0f alpha:1.0f] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
	[button setBackgroundImage:[[UIImage imageNamed:@"btn_light_blue_lg.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"btn_light_blue_lg_press.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor clearColor];
	return button;	
}

@end
