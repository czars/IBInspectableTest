//
//  TSProductSwitch2.m
//  IBInspectableTest
//
//  Created by Ryan on 2016/5/14.
//  Copyright © 2016年 Czars. All rights reserved.
//

#import "TSProductSwitch2.h"

@implementation TSProductSwitch2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self.class loadFromXib];
    self.frame = frame;
    return self;
}

+ (instancetype)loadFromXib {
    NSArray* elements = [[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            return anObject;
        }
    }
    return nil;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.layer setBorderWidth: 5.0];
    [self.layer setBorderColor: [UIColor redColor].CGColor];
    [self setBackgroundColor: [UIColor blueColor]];
}

-(void)setFontSize:(NSUInteger)fontSize{
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont fontWithName: @"AvenirNext-Regular"
                                           size: _fontSize];
}

-(void)setCheckedTitle:(NSString *)checkedTitle{
    _checkedTitle = checkedTitle;
    if (_isOn) {
        self.titleLabel.text=_checkedTitle;
    }
    
}

-(void)setUnCheckedTitle:(NSString *)unCheckedTitle
{
    _unCheckedTitle = unCheckedTitle;
    if (!_isOn) {
        self.titleLabel.text= _unCheckedTitle;
    }
    
}

-(void)setOn:(BOOL)on{}
-(IBAction)pressSwitchButton:(id)sender{}

@end
