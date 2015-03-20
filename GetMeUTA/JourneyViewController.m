//
//  ViewController.m
//  GetMeUtaJourney
//
//  Created by Cal Henrie on 3/11/15.
//  Copyright (c) 2015 calhenrie. All rights reserved.
//

#import "JourneyViewController.h"
#import "StationViewCell.h"

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
    self.tableView.backgroundColor = [UIColor colorWithRed:0.757f green:0.859f blue:0.933f alpha:1.00f];
    
    [self.tableView registerClass:[StationViewCell class] forCellReuseIdentifier:NSStringFromClass([StationViewCell class])];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    headerView.backgroundColor = [UIColor colorWithRed:0.757f green:0.859f blue:0.933f alpha:1.00f];
    self.timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,headerView.frame.size.width,165)];
    self.timerLabel.text = @"15";
    self.timerLabel.font = [UIFont  systemFontOfSize:200];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    [self.timerLabel setCenter:headerView.center];
    [headerView addSubview:self.timerLabel];
    
    self.timerText=[[UILabel alloc]initWithFrame: CGRectMake(0,60, headerView.frame.size.width,30)];
    self.timerText.text = @"Your train leaves the station in:";
    self.timerText.lineBreakMode = NSLineBreakByWordWrapping;
    self.timerText.font = [UIFont systemFontOfSize:25];
    self.timerText.backgroundColor = [UIColor colorWithRed:0.757f green:0.859f blue:0.933f alpha:1.00f];
    self.timerText.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.timerText];
    
    self.departureTime = [[UILabel alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height -120, headerView.frame.size.width, 60)];
    self.departureTime.text = @"5:46";
    self.departureTime.font = [UIFont systemFontOfSize:40];
    self.departureTime.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.departureTime];
    
    self.departureText = [[UILabel alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height -180, headerView.frame.size.width, 60)];
    self.departureText.text = @"Your Train Departs at:";
    self.departureText.font = [UIFont systemFontOfSize:25];
    self.departureText.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.departureText];
    
    
    
    self.tableView.tableHeaderView = headerView;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	int height;
//	if(indexPath.row == 0){
//		height = self.view.frame.size.height;
//	}
//	else if (indexPath.row > 0){
//		height = 44;
//	}
//	return height;
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16
    ;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    StationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StationViewCell class])];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed:0.757f green:0.859f blue:0.933f alpha:1.00f];
}



// Do any additional setup after loading the view, typically from a nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


