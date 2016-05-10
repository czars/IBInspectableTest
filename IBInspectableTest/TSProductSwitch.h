//
//  TSProductSwitch.h
//  CityPair
//
//  Created by Paul.Chou on 2016/5/9.
//  Copyright © 2016年 TravelStart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSProductSwitchDelegate <NSObject>

-(void)didChangeSwitchValue:(BOOL)isOn;

@end

IB_DESIGNABLE
@interface TSProductSwitch : UIView

@property (nonatomic, weak) id<TSProductSwitchDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;
@property (weak, nonatomic) IBOutlet UIImageView *uncheckBoxImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *SwitchButton;

//@property (nonatomic, strong) IBInspectable UIImage *animationImage;
@property (nonatomic, assign) IBInspectable BOOL isOn;
@property (nonatomic, assign) IBInspectable BOOL reverseAnimation;
@property (nonatomic, strong) IBInspectable NSString *checkedTitle;
@property (nonatomic, strong) IBInspectable NSString *unCheckedTitle;
@property (nonatomic, strong) IBInspectable UIImage *animationImage;

-(void)setOn:(BOOL)on;
-(IBAction)pressSwitchButton:(id)sender;

@end
