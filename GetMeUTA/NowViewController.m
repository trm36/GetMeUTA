//
//  ViewController.m
//  GetMe
//
//  Created by Paul Shelley on 3/10/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "NowViewController.h"
#import "NSObject+UIColor.h"
#import "ButtonController.h"
#import "Button.h"

@interface NowViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;


@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self drawMainView];
    
}

- (void)drawMainView {
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.mainView.backgroundColor = [UIColor lightBlue];
    [self.view addSubview:self.mainView];
    
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
    [self.mainView addSubview:getMe];
    
    UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 40, 30, 30)];
    plusButton.titleLabel.font = [UIFont systemFontOfSize:50];
    plusButton.tag = 33;
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    [plusButton setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(addButtonPressedWithTag:)forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:plusButton];
    
    [ButtonController sharedInstance];
    int count = (int)[ButtonController sharedInstance].buttons.count;
    int i = 0;
    for (i = 0; i < count; i++) {
        NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
        Button *button = arrayOfButtons[i];
        NSString *title = button.title;
        
        [self drawAButtonWithName:title numberOfButtons:(count + 1) buttonNumber:i];
    }
    [self drawPlanButton:(count +1) buttonNumber:i];
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
    button.backgroundColor = [UIColor darkBlue];
    button.layer.cornerRadius = 5;
    button.tag = buttonNumber + 1;
    [button setTitle:name forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(favoritesButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:button];
}

- (void)favoritesButtonPressed:(id)sender {
    
    UIButton *buttonSent = [UIButton new];
    buttonSent = sender;
    
    int tag = (int)buttonSent.tag -1;
    
    NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
    Button *buttonSaved = arrayOfButtons[tag];
    NSString *needsSetup = buttonSaved.needsSettup;
    
    if ([needsSetup isEqualToString:@"YES"]) {
        [self addButtonPressedWithTag:tag];
    }
}

- (void)drawPlanButton:(int)numberOfButtons buttonNumber:(int)buttonNumber {
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    float buttonWidth = viewWidth / 2.3;
    float buttonHeight = 40;
    float buttonHorizontal = (viewWidth / 2) - (buttonWidth / 2);
    float startVerticle = (viewHeight / 2) - (buttonHeight / 2) - (numberOfButtons * 20);
    float buttonVerticle = startVerticle + (buttonNumber * 90);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
    button.backgroundColor = [UIColor darkRed];
    button.layer.cornerRadius = 5;
    [button setTitle:@"plan" forState:UIControlStateNormal];
    [self.mainView addSubview:button];
}

- (void)addButtonPressedWithTag:(int)tag {
    
    if ([ButtonController sharedInstance].buttons.count >= 3 && !(0 <= tag && tag <= 2) ) {
        NSLog(@"You can't add more than three Fav buttons");
        return;
    }
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.view.frame;
    [self.view addSubview:self.blurEffectView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * .1, 80, self.view.bounds.size.width * .8, self.view.bounds.size.height * .3)];
    view.backgroundColor = [UIColor colorWithRed:256 green:256 blue:256 alpha:.7];
    view.layer.cornerRadius = 10;
    [self.blurEffectView.contentView addSubview:view];
    
    UIButton *xButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 40, 30, 30)];
    xButton.titleLabel.font = [UIFont systemFontOfSize:50];
    [xButton setTitle:@"+" forState:UIControlStateNormal];
    [xButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(xButtonPressed)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:xButton];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * .1, 100, self.view.bounds.size.width * .8, 40)];
    
    if (0 <= tag && tag <= 2) {
        NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
        Button *buttonSaved = arrayOfButtons[tag];
        //NSString *buttonTitle = buttonSaved.title;
        //NSString *station = buttonSaved.station;
        
        self.nameTextField.text = buttonSaved.title;
    }
    
    self.nameTextField.placeholder = @"button name";
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.blurEffectView.contentView addSubview:self.nameTextField];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * .1, 180, self.view.bounds.size.width * .8, 40)];
    //saveButton.titleLabel.font = [UIFont systemFontOfSize:50];
    saveButton.backgroundColor = [UIColor darkRed];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButton)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:saveButton];
}

- (void)xButtonPressed {
    [self.blurEffectView removeFromSuperview];
    [self.mainView removeFromSuperview];
    [self drawMainView];
}

- (void)saveButton {
    
    if (self.nameTextField) {
        
        Button *newButton = [[Button alloc] init];
        newButton.title = self.nameTextField.text;
        newButton.station = @"Meadowbrook";
        newButton.needsSettup = @"NO";
        
        [[ButtonController sharedInstance] addButton:newButton];
    }
}

//- (void)updateWithName:(Name *)name {
//    self.name = name;
//    self.nameField.text = name.name;
//}
//
//- (void)refresh {
//    [self updateWithName:self.name];
//}


@end
