//
//  ViewController.m
//  GetMeUtaJourney
//
//  Created by Cal Henrie on 3/11/15.
//  Copyright (c) 2015 calhenrie. All rights reserved.
//

#import "JourneyViewController.h"
#import "StationViewCell.h"
#import "NSObject+UIColor.h"

@interface JourneyViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *timerText;
@property (nonatomic, strong) UILabel *departureTime;
@property (nonatomic, strong) UILabel *departureText;

@end

@implementation JourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerClass:[StationViewCell class] forCellReuseIdentifier:NSStringFromClass([StationViewCell class])];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    float height = self.view.frame.size.height;
    float width = self.view.frame.size.width;
    float lableWidth = self.view.frame.size.width * 0.8;
    float lableHorizontalPosition = self.view.frame.size.width *0.1;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    headerView.backgroundColor = [UIColor redColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 60)];
//    backButton.tintColor = [UIColor darkBlue];
    [backButton setTitleColor:[UIColor darkBlue] forState:UIControlStateNormal];
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed)forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    UILabel *topText1 = [[UILabel alloc] initWithFrame:CGRectMake(lableHorizontalPosition, 90, lableWidth, 40)];
    topText1.text = @"The train leaves";
    topText1.textColor = [UIColor darkBlue];
    //[message setFont:[UIFont boldSystemFontOfSize:18]];
    topText1.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:topText1];
    
    UILabel *topText2 = [[UILabel alloc] initWithFrame:CGRectMake(lableHorizontalPosition, 110, lableWidth, 40)];
    topText2.text = @"the station at:";
    topText2.textColor = [UIColor darkBlue];
    //[message setFont:[UIFont boldSystemFontOfSize:18]];
    topText2.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:topText2];
    
    self.timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (height * .5) - 80, headerView.frame.size.width, 80)];
    self.timerLabel.text = @"8:23";
    self.timerLabel.font = [UIFont  fontWithName:@"HelveticaNeue-UltraLight" size:80];
    self.timerLabel.textColor = [UIColor darkBlue];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.timerLabel];
    
    UILabel *departureAM = [[UILabel alloc]initWithFrame:CGRectMake( ((width / 2) +52), (height * .5) - 48, 100, 60)];
    departureAM.text = @"am";
    departureAM.textColor = [UIColor darkBlue];
    departureAM.font = [UIFont  fontWithName:@"HelveticaNeue-Light" size:20];
    departureAM.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:departureAM];
    
    UILabel *bottonText = [[UILabel alloc] initWithFrame:CGRectMake(lableHorizontalPosition, height - 200, lableWidth, 40)];
    bottonText.text = @"The train arrives at:";
    bottonText.textColor = [UIColor darkBlue];
    //[message setFont:[UIFont boldSystemFontOfSize:18]];
    bottonText.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:bottonText];
    
    self.departureTime = [[UILabel alloc]initWithFrame:CGRectMake(0, height -160, headerView.frame.size.width, 60)];
    self.departureTime.text = @"8:46";
    self.departureTime.textColor = [UIColor darkBlue];
    self.departureTime.font = [UIFont  fontWithName:@"HelveticaNeue-UltraLight" size:40];
    self.departureTime.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.departureTime];
    
    UILabel *arrivalAM = [[UILabel alloc]initWithFrame:CGRectMake( ((width / 2) +10), height -152, 100, 60)];
    arrivalAM.text = @"am";
    arrivalAM.textColor = [UIColor darkBlue];
    arrivalAM.font = [UIFont  fontWithName:@"HelveticaNeue-Light" size:15];
    arrivalAM.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:arrivalAM];
    
    
    self.tableView.tableHeaderView = headerView;
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16
    ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StationViewCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


