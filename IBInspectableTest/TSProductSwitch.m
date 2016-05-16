//
//  TSProductSwitch.m
//  CityPair
//
//  Created by Paul.Chou on 2016/5/9.
//  Copyright © 2016年 TravelStart. All rights reserved.
//

#import "TSProductSwitch.h"

#define COLOR_MAIN          [UIColor colorWithRed:53.0/255 green:192.0/255 blue:240.0/255 alpha:1.0]
#define COLOR_DARK_TEXT       [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0]

@implementation TSProductSwitch

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
        if (self) {
            [self commonInit];
        }
        return self;
}

//+ (instancetype)loadFromXib {
//    NSArray* elements = [[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
//    for (id anObject in elements) {
//        if ([anObject isKindOfClass:[self class]]) {
//            NSLog(@"get view from xib");
//            return anObject;
//        }
//    }
//    return nil;
//}

//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    [self.layer setBorderWidth: 5.0];
//    [self.layer setBorderColor: [UIColor redColor].CGColor];
//    [self setBackgroundColor: [UIColor blueColor]];
//}

-(void)commonInit{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TSProductSwitch" owner:self options:nil] firstObject];
    [self addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    id bindings = @{ @"view": view };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:bindings]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:bindings]];

    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
        _reverseAnimation = NO;
    }else if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft){
        _reverseAnimation = YES;
    }
    _fontSize = 10;
    _isOn = NO;
    
}

-(void)setOn:(BOOL)on{
    [self.animationImageView setHidden:!on];
    [self.uncheckBoxImageView setHidden:on];
    [self.checkBoxImageView setHidden:!on];
    self.checkBoxImageView.layer.transform = CATransform3DMakeScale(on?1:0.00000001, on?1:0.00000001, on?1:0.00000001);
    if (on) {
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:_fontSize];
        self.titleLabel.textColor = COLOR_DARK_TEXT;
        
    }else{
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:_fontSize];
        self.titleLabel.textColor = COLOR_MAIN;
        
    }
}

-(void)pressSwitchButton:(id)sender{
    self.isOn = !self.isOn;
    [self animationWithOnOff:self.isOn];
    [self.delegate didChangeSwitchValue:self.isOn];
}

- (CAKeyframeAnimation *)fillAnimationWithBounces:(NSUInteger)bounces amplitude:(CGFloat)amplitude reverse:(BOOL)reverse {
    NSMutableArray *values = [NSMutableArray new];
    NSMutableArray *keyTimes = [NSMutableArray new];
    
    if (reverse) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    } else {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.5)]];
    }
    
    [keyTimes addObject:@0.0];
    
    for (NSUInteger i = 1; i <= bounces; i++) {
        CGFloat scale = (i % 2) ? (1 + amplitude/i) : (1 - amplitude/i);
        CGFloat time = i * 1.0/(bounces + 1);
        
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, scale)]];
        [keyTimes addObject:[NSNumber numberWithFloat:time]];
    }
    
    if (reverse) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]];
    } else {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    }
    
    [keyTimes addObject:@1.0];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = values;
    animation.keyTimes = keyTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return animation;
}

-(void)animationWithOnOff:(BOOL)on{
    
    if (on) {
        [self.uncheckBoxImageView setHidden:YES];
        [self.checkBoxImageView.layer addAnimation:[self fillAnimationWithBounces:1 amplitude:0.35 reverse:NO]  forKey:@"transform"];
        [self.animationImageView setTranslatesAutoresizingMaskIntoConstraints:YES];
        if (!_reverseAnimation) {
            [self.animationImageView setFrame:CGRectMake(-self.animationImageView.frame.size.width, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
            [self.animationImageView setHidden:NO];
            [UIView animateWithDuration:0.3 animations:^{
                [self.animationImageView setFrame:CGRectMake(0, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
                self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:_fontSize];
                self.titleLabel.textColor = COLOR_DARK_TEXT;
            } completion:^(BOOL finished) {
                self.checkBoxImageView.layer.transform = CATransform3DIdentity;
            }];
        }else if (_reverseAnimation){
            [self.animationImageView setFrame:CGRectMake(self.animationImageView.frame.size.width-40, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
            [self.animationImageView setHidden:NO];
            [UIView animateWithDuration:0.3 animations:^{
                [self.animationImageView setFrame:CGRectMake(-40, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
                self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:_fontSize];
                self.titleLabel.textColor = COLOR_DARK_TEXT;
            } completion:^(BOOL finished) {
                self.checkBoxImageView.layer.transform = CATransform3DIdentity;
            }];
        }
    }else{
        [self.checkBoxImageView.layer addAnimation:[self fillAnimationWithBounces:0 amplitude:0.35 reverse:YES]  forKey:@"transform"];
        [self.uncheckBoxImageView setHidden:NO];
        if (!_reverseAnimation) {
            
            [self.animationImageView setHidden:YES];
            [self.animationImageView setFrame:CGRectMake(-self.animationImageView.frame.size.width, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:_fontSize];
                self.titleLabel.textColor = COLOR_MAIN;
            } completion:^(BOOL finished) {
                
            }];
        }else if (_reverseAnimation){
            [self.animationImageView setHidden:YES];
            [self.animationImageView setFrame:CGRectMake(self.animationImageView.frame.size.width-40, 0, self.animationImageView.frame.size.width, self.animationImageView.frame.size.height)];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:_fontSize];
                self.titleLabel.textColor = COLOR_MAIN;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark IBInspectable function

-(void)setFontSize:(NSUInteger)fontSize{
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont fontWithName:_isOn?@"AvenirNext-Regular":@"AvenirNext-DemiBold" size:_fontSize];
}

-(void)setCheckedTitle:(NSString *)checkedTitle{
    _checkedTitle = checkedTitle;
    if (_isOn) {
        _titleLabel.text=_checkedTitle;
    }
}

-(void)setUnCheckedTitle:(NSString *)unCheckedTitle
{
    _unCheckedTitle = unCheckedTitle;
    if (!_isOn) {
        _titleLabel.text= _unCheckedTitle;
    }
}

-(void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    _titleLabel.text = _isOn?_checkedTitle:_unCheckedTitle;

    [self.animationImageView setHidden:!isOn];
    [self.uncheckBoxImageView setHidden:isOn];
    [self.checkBoxImageView setHidden:!isOn];
    if (isOn) {
        
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:_fontSize];
        self.titleLabel.textColor = COLOR_DARK_TEXT;
    }else{
        
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:_fontSize];
        self.titleLabel.textColor = COLOR_MAIN;

    }
    
}

-(void)setReverseAnimation:(BOOL)reverseAnimation{
    _reverseAnimation = reverseAnimation;
}

-(void)setAnimationImage:(UIImage *)animationImage{
    _animationImage = animationImage;
    _animationImageView.image = _animationImage;
}

@end
