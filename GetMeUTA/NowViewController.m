//
//  FirstViewController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 6.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "NowViewController.h"
#import "StopController.h"

@interface NowViewController ()

@end

@implementation NowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//for test
    [[StopController sharedInstance] pullStopTimesWithStopID:@18390]; //check method
//    [[StopController sharedInstance] convertCurrentTimeFormat];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
