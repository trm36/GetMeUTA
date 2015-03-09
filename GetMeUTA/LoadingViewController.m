//
//  LoadingViewController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 8.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "LoadingViewController.h"
#import "CHCSVParser.h"
#import "StopController.h"
#import "RouteController.h"
#import "TripController.h"
#import "StopTimeController.h"

@interface LoadingViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *informationLabel;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    BOOL isDataParsed = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    
    if (isDataParsed)
    {
        self.activityIndicator.hidden = YES;
        [self performSegueWithIdentifier:@"parsedData" sender:self];
    }
    else
    {
        self.informationLabel.hidden = NO;
        
        [self setStops];
        [self setRoutes];
        [self setTrips];
//        [self setStopTimes];
//        [self setCalendar];
//        [self setCalendarDates];
        
        [self setDataParsedValue:YES];
        
        [self.activityIndicator stopAnimating];
        
        [self performSegueWithIdentifier:@"parsedData" sender:self];
    }

}

- (void)setStops
{
    NSURL *csvurl = [[NSBundle mainBundle] URLForResource:@"stops" withExtension:@"csv"];
    
    NSArray *stops = [NSArray arrayWithContentsOfCSVURL:csvurl options:CHCSVParserOptionsUsesFirstLineAsKeys];
    
    for (CHCSVOrderedDictionary *dictionary in stops)
    {
        [[StopController sharedInstance] addStopWithCHCSVOrderedDictionary:dictionary];
    }
    
    stops = nil;
}

- (void)setStopTimes
{
    NSURL *csvurl = [[NSBundle mainBundle] URLForResource:@"stop_times" withExtension:@"csv"];
    
    NSArray *stopTimes = [NSArray arrayWithContentsOfCSVURL:csvurl options:CHCSVParserOptionsUsesFirstLineAsKeys];
    
    for (CHCSVOrderedDictionary *dictionary in stopTimes)
    {
        [[StopTimeController sharedInstance] addStopTimeWithCHCSVOrderedDictionary:dictionary];
    }
    
    stopTimes = nil;
}

- (void)setRoutes
{
    NSURL *csvurl = [[NSBundle mainBundle] URLForResource:@"routes" withExtension:@"csv"];
    
    NSArray *routes = [NSArray arrayWithContentsOfCSVURL:csvurl options:CHCSVParserOptionsUsesFirstLineAsKeys];
    
    for (CHCSVOrderedDictionary *dictionary in routes)
    {
        [[StopController sharedInstance] addStopWithCHCSVOrderedDictionary:dictionary];
    }
    
    routes = nil;
}

- (void)setTrips
{
    NSURL *csvurl = [[NSBundle mainBundle] URLForResource:@"trips" withExtension:@"csv"];
    
    NSArray *trips = [NSArray arrayWithContentsOfCSVURL:csvurl options:CHCSVParserOptionsUsesFirstLineAsKeys];
    
    for (CHCSVOrderedDictionary *dictionary in trips)
    {
        [[TripController sharedInstance] addTripWithCHCSVOrderedDictionary:dictionary];
    }
    
    trips = nil;
    
}

- (void)setCalendarDates
{
#warning implement this
}

- (void)setCalendar
{
#warning implement this
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Check if data has been parsed

- (void)setDataParsedValue:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:@"data"];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)getDataParsedValue
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"data"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
