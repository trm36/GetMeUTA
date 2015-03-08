//
//  SecondViewController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 6.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UIPickerView *fromPicker;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fromPicker.delegate = self;
    self.fromPicker.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma picker - 

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[component][row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.pickerData count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData[component] count];
}

- (NSArray *)pickerData {
    
    return @[
             [self from],
             [self to],
             ];
    
}

- (NSArray *)from {
    return @[@"Pleasant View",
             @"Ogden",
             @"Roy",
             @"Clearfield",
             @"Layton",
             @"Farmington",
             @"Woods Cross",
             @"North Temple",
             @"Salt Lake Central",
             @"Murray Central",
             @"South Jordan",
             @"Draper",
             @"Lehi",
             @"American Fork",
             @"Orem",
             @"Provo"];
}

- (NSArray *)to {
    return @[@"Pleasant View",
             @"Ogden",
             @"Roy",
             @"Clearfield",
             @"Layton",
             @"Farmington",
             @"Woods Cross",
             @"North Temple",
             @"Salt Lake Central",
             @"Murray Central",
             @"South Jordan",
             @"Draper",
             @"Lehi",
             @"American Fork",
             @"Orem",
             @"Provo"];
}

@end

