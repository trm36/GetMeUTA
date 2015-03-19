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
#include <math.h>

//            return |name-| pType   |param-| |-Function-------------------|
static inline double radians (double degrees) {return degrees * M_PI / 180;}

@interface NowViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *xButton;

@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.plusButton.center = CGPointMake(self.view.frame.size.width - 42, 56);
    self.xButton.center = CGPointMake(self.view.frame.size.width - 42, 56);
    [self drawMainView];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (void)drawMainView {
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainView.backgroundColor = [UIColor whiteColor];
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
    getMe.textColor = [UIColor darkRed];
    [self.mainView addSubview:getMe];
    
    self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 40, 40, 40)];
    self.plusButton.titleLabel.font = [UIFont systemFontOfSize:50];
    self.plusButton.tag = 33;
    [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
    [self.plusButton setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
    [self.plusButton addTarget:self action:@selector(addOrEditButtonWithTag:)forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.plusButton];
    
    [ButtonController sharedInstance];
    int count = (int)[ButtonController sharedInstance].buttons.count;
    int i = 0;
    for (i = 0; i < count; i++) {
        NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
        Button *button = arrayOfButtons[i];
        NSString *title = button.title;
        
        [self drawAButtonWithName:title numberOfButtons:(count + 1) buttonNumber:i];
    }
    [self drawPlanButton:(count + 1) buttonNumber:i];
    
    if (count < 3) {
        [self drawHelpText];
    }
    
}

- (void)drawHelpText {
    
//    UILabel *plusButtonHelp = [[UILabel alloc] initWithFrame:CGRectMake(10, 52, self.view.frame.size.width * .8, 20)];
//    plusButtonHelp.text = @"tap to add quick route buttons ->";
//    plusButtonHelp.textColor = [UIColor darkBlue];
//    //[message setFont:[UIFont boldSystemFontOfSize:18]];
//    plusButtonHelp.textAlignment = NSTextAlignmentCenter;
//    [self.mainView addSubview:plusButtonHelp];
    
    //float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float lableWidth = self.view.frame.size.width * 0.8;
    float lableHorizontalPosition = self.view.frame.size.width *0.1;
    
    UILabel *helpLine1 = [[UILabel alloc] initWithFrame:CGRectMake(lableHorizontalPosition, height - 100, lableWidth, 40)];
    helpLine1.text = @"find your way home,";
    helpLine1.textColor = [UIColor darkBlue];
    //[message setFont:[UIFont boldSystemFontOfSize:18]];
    helpLine1.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:helpLine1];

    UILabel *helpLine2 = [[UILabel alloc] initWithFrame:CGRectMake(lableHorizontalPosition, height - 80, lableWidth, 40)];
    helpLine2.text = @"or plan a one time trip.";
    helpLine2.textColor = [UIColor darkBlue];
    //[message setFont:[UIFont boldSystemFontOfSize:18]];
    helpLine2.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:helpLine2];
    
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
    button.tag = buttonNumber;
    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:@selector(favoritesButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    [longPress addTarget:self action:@selector(longPressButton)];
    [button addGestureRecognizer:longPress];
    //[longPress release];
    
    [self.mainView addSubview:button];
}

- (void)longPressButton {
    [self drawDeleteButtons];
    [self drawEditButtons];
}

- (void)drawDeleteButtons {
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    float buttonWidth = 26;
    float buttonHeight = 26;
    
    int numberOfButtons = (int)[ButtonController sharedInstance].buttons.count;
    numberOfButtons = numberOfButtons + 1;
    
    for (int i = 0; i < (numberOfButtons - 1); i++) {
        
        float buttonHorizontal = (viewWidth / 4) - (buttonWidth / 4) + 5;
        float startVerticle = (viewHeight / 2) - (buttonHeight / 2) - (numberOfButtons * 20);
        float buttonVerticle = startVerticle + (i * 90) - 17;
        
        UIButton *circle = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
        circle.backgroundColor = [UIColor clearWhite];
        circle.layer.cornerRadius = 13;
        circle.tag = i;
        [circle setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
        [circle setTitle:@"" forState:UIControlStateNormal];
        [circle addTarget:self action:@selector(deleteButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:circle];
        
        UIButton *littleX = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
        littleX.tag = i;
        littleX.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [littleX setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
        [littleX setTitle:@"+" forState:UIControlStateNormal];
        [littleX addTarget:self action:@selector(deleteButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:littleX];
        
        CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(radians(45.0));
        
        [UIView animateWithDuration:0.0 animations:^{
            littleX.center = CGPointMake(buttonHorizontal + 15, buttonVerticle + 12);
            littleX.transform = rotationTransform;
        }completion:^(BOOL finished) {
        }];
    }
    
    
}

- (void)drawEditButtons {
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    float buttonWidth = 40;
    float buttonHeight = 26;
    
    int numberOfButtons = (int)[ButtonController sharedInstance].buttons.count;
    numberOfButtons = numberOfButtons + 1;
    
    for (int i = 0; i < (numberOfButtons - 1); i++) {
        
        float buttonHorizontal = (viewWidth / 2) + (buttonWidth) + 5;
        float startVerticle = (viewHeight / 2) - (buttonHeight / 2) - (numberOfButtons * 20);
        float buttonVerticle = startVerticle + (i * 90) - 17;
        
        UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonHorizontal, buttonVerticle, buttonWidth, buttonHeight)];
        editButton.backgroundColor = [UIColor clearWhite];
        editButton.layer.cornerRadius = 13;
        editButton.tag = i;
        [editButton setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
        [editButton setTitle:@"edit" forState:UIControlStateNormal];
        
        [editButton addTarget:self action:@selector(editButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:editButton];
    }
}

- (void)editButtonPressed:(id)sender {
    UIButton *buttonSent = [UIButton new];
    buttonSent = sender;
    int tag = (int)buttonSent.tag;
    [self addOrEditButtonWithTag:tag];
}

- (void)favoritesButtonPressed:(id)sender {
    
    UIButton *buttonSent = [UIButton new];
    buttonSent = sender;
    int tag = (int)buttonSent.tag;
    NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
    Button *buttonSaved = arrayOfButtons[tag];
    NSString *needsSetup = buttonSaved.needsSettup;
    
    if ([needsSetup isEqualToString:@"YES"]) {
        [self addOrEditButtonWithTag:tag];
    }
}

- (void)deleteButtonPressed:(id)sender {
    UIButton *buttonSent = [UIButton new];
    buttonSent = sender;
    NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
    Button *oldButton = arrayOfButtons[buttonSent.tag];
    [[ButtonController sharedInstance] removeButton:oldButton];
    
    [self drawMainView];
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

- (void)addOrEditButtonWithTag:(int)tag {
    
    if ([ButtonController sharedInstance].buttons.count >= 3 && !(0 <= tag && tag <= 2) ) {
        NSLog(@"You can't add more than three Fav buttons");
        [self tooManyButtons];
        return;
    }
    
    [self drawBlurEffectView];
    [self drawXButton];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 80, self.view.frame.size.width * .8, self.view.bounds.size.height * .3)];
    view.backgroundColor = [UIColor colorWithRed:256 green:256 blue:256 alpha:.7];
    view.layer.cornerRadius = 10;
    [self.blurEffectView.contentView addSubview:view];
    
    [self fadeInEffect];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 100, self.view.frame.size.width * .8, 40)];
    self.nameTextField.delegate = self;
    
    if (0 <= tag && tag <= 2) {
        NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
        Button *buttonSaved = arrayOfButtons[tag];
        
        self.nameTextField.text = buttonSaved.title;
    }
    
    self.nameTextField.placeholder = @"button name";
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.blurEffectView.contentView addSubview:self.nameTextField];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 180, self.view.frame.size.width * .8, 40)];
    //saveButton.titleLabel.font = [UIFont systemFontOfSize:50];
    saveButton.backgroundColor = [UIColor darkRed];
    saveButton.tag = tag;
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButton:)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:saveButton];
}

- (void)drawBlurEffectView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.view.frame;
    self.blurEffectView.alpha = 0.0;
    [self.view addSubview:self.blurEffectView];
    
}

- (void)drawXButton {
    self.xButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 40, 40, 40)];
    self.xButton.titleLabel.font = [UIFont systemFontOfSize:50];
    [self.xButton setTitle:@"+" forState:UIControlStateNormal];
    [self.xButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [self.xButton addTarget:self action:@selector(fadeOut)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:self.xButton];
}

- (void)fadeInEffect {
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(radians(315.0));
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blurEffectView.alpha = 0.9;
        self.plusButton.transform = rotationTransform;
        self.xButton.transform = rotationTransform;
    }completion:^(BOOL finished) {
    }];
}

- (void)tooManyButtons {
    
    [self drawBlurEffectView];
    [self drawXButton];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 80, self.view.frame.size.width * .8, 210)];
    view.backgroundColor = [UIColor colorWithRed:256 green:256 blue:256 alpha:.7];
    view.layer.cornerRadius = 10;
    [self.blurEffectView.contentView addSubview:view];
    
    [self fadeInEffect];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 100, self.view.frame.size.width * .8, 40)];
    message.text = @"Button Limit Reached";
    [message setFont:[UIFont boldSystemFontOfSize:18]];
    message.textAlignment = NSTextAlignmentCenter;
    [self.blurEffectView.contentView addSubview:message];
    
    UILabel *messageBody = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .15, 130, self.view.frame.size.width * .7, 80)];
    messageBody.text = @"Touch and hold a button to edit or delete it.";
    messageBody.lineBreakMode = NSLineBreakByWordWrapping;
    messageBody.numberOfLines = 0;
    messageBody.textAlignment = NSTextAlignmentCenter;
    [self.blurEffectView.contentView addSubview:messageBody];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .1, 220, self.view.frame.size.width * .8, 40)];
    //saveButton.titleLabel.font = [UIFont systemFontOfSize:50];
    okButton.backgroundColor = [UIColor darkRed];
    [okButton setTitle:@"ok" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor colorWithRed:256 green:256 blue:256 alpha:.7] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(fadeOut)forControlEvents:UIControlEventTouchUpInside];
    [self.blurEffectView.contentView addSubview:okButton];
}

- (void)fadeOut {
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(radians(0.0));
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blurEffectView.alpha = 0.0;
        self.plusButton.transform = rotationTransform;
        self.xButton.transform = rotationTransform;
    }completion:^(BOOL finished) {
    }];
}

- (void)saveButton:(id)sender {
    
    UIButton *buttonSent = [UIButton new];
    buttonSent = sender;
    
    if (buttonSent.tag > 10) {
        Button *newButton = [[Button alloc] init];
        newButton.title = self.nameTextField.text;
        newButton.station = @"Meadowbrook";
        newButton.needsSettup = @"YES";
        
        [[ButtonController sharedInstance] addButton:newButton];
        
        [self.nameTextField resignFirstResponder];
        [self drawMainView];
        [self fadeOut];
    } else {
        
        NSArray *arrayOfButtons = [ButtonController sharedInstance].buttons;
        Button *oldButton = arrayOfButtons[buttonSent.tag];
        
        Button *newButton = [[Button alloc] init];
        newButton.title = self.nameTextField.text;
        newButton.station = @"Meadowbrook";
        newButton.needsSettup = @"NO";
        
        [[ButtonController sharedInstance] replaceButton:oldButton withButton:newButton];
        
        [self.nameTextField resignFirstResponder];
        [self drawMainView];
        [self fadeOut];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
