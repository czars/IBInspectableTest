//
//  ViewController.m
//  IBInspectableTest
//
//  Created by Czars on 2016/5/10.
//  Copyright © 2016年 Czars. All rights reserved.
//

#import "ViewController.h"
#import "TSProductSwitch.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TSProductSwitch *productSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TSProductSwitch Delegae

-(void)didChangeSwitchValue:(BOOL)isOn{
    NSLog(@"tapped switch control %d",isOn);
}


@end
