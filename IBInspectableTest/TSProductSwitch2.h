//
//  TSProductSwitch2.h
//  IBInspectableTest
//
//  Created by Ryan on 2016/5/14.
//  Copyright © 2016年 Czars. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSProductSwitchDelegate <NSObject>

-(void)didChangeSwitchValue:(BOOL)isOn;

@end

IB_DESIGNABLE

@interface TSProductSwitch2 : UIView

@property (nonatomic, weak) id<TSProductSwitchDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;
@property (weak, nonatomic) IBOutlet UIImageView *uncheckBoxImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *SwitchButton;

//@property (nonatomic, strong) IBInspectable UIImage *animationImage;
@property (nonatomic, assign) IBInspectable BOOL isOn;
@property (nonatomic, assign) IBInspectable BOOL reverseAnimation;
@property (nonatomic, assign) IBInspectable NSUInteger fontSize;
@property (nonatomic, strong) IBInspectable NSString *checkedTitle;
@property (nonatomic, strong) IBInspectable NSString *unCheckedTitle;
@property (nonatomic, strong) IBInspectable UIImage *animationImage;


-(void)setOn:(BOOL)on;
-(IBAction)pressSwitchButton:(id)sender;

@end
