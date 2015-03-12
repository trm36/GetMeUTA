//
//  ViewController.m
//  GetMe
//
//  Created by Paul Shelley on 3/10/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "NowViewController.h"
#import "NSObject+UIColor.h"

@interface NowViewController ()

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightBlue];
    
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    float getMeWidth = viewWidth;
    float getMeHeight = 60;
    float getMeHorizontal = (viewWidth / 2) - (getMeWidth / 2);
    float GetMeVerticle = viewHeight * .15;
    
    UILabel *getMe = [[UILabel alloc] initWithFrame:CGRectMake(getMeHorizontal, GetMeVerticle, getMeWidth, getMeHeight)];
    getMe.text = @"Get Me";
    getMe.textAlignment = NSTextAlignmentCenter;
    [getMe setFont:[UIFont boldSystemFontOfSize:50]];
    //getMe.backgroundColor = [UIColor whiteColor];
    getMe.textColor = [UIColor darkRed];
    [self.view addSubview:getMe];
    
    UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 40, 30, 30)];
    plusButton.titleLabel.font = [UIFont systemFontOfSize:50];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    [plusButton setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonPressed)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:plusButton];
    
    for (int i = 0; i < 2; i++) {
        [self drawAButtonWithName:@"home" numberOfButtons:2 buttonNumber:i];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawAButtonWithName:(NSString *)name numberOfButtons:(int)numberOfButtons buttonNumber:(int)buttonNumber {
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    float buttonWidth = viewWidth / 2.3;
    float buttonHeight = 40;
    float buttonHorizontal = (viewWidth / 2) - (buttonWidth / 2);
    float startVerticle = (viewHeight / 2) - (buttonHeight / 2) - (numberOfButtons * 20);
    float buttonVerticle = startVerticle + (buttonNumber * 90);
    
    UIColor *color;
    
    if (buttonNumber == numberOfButtons - 1) {
        color = [UIColor darkRed];
    } else {
        color = [UIColor darkBlue];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
    button.backgroundColor = color;
    button.layer.cornerRadius = 5;
    [button setTitle:name forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)plusButtonPressed {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.view.frame;
    [self.view addSubview:self.blurEffectView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * .1, 80, self.view.bounds.size.width * .8, self.view.bounds.size.height * .2)];
    view.backgroundColor = [UIColor colorWithRed:256 green:256 blue:256 alpha:.7];
    view.layer.cornerRadius = 10;
    [self.blurEffectView.contentView addSubview:view];
    
    UIButton *xButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 40, 30, 30)];
    xButton.titleLabel.font = [UIFont systemFontOfSize:50];
    [xButton setTitle:@"+" forState:UIControlStateNormal];
    [xButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(xButtonPressed)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:xButton];
}

- (void)xButtonPressed {
    [self.blurEffectView removeFromSuperview];
}



@end
