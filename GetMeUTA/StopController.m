//
//  StopController.m
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "StopController.h"
#import "Stop.h"
#import <Parse/Parse.h>

static NSString * const tripIDKey = @"tripID";
static NSString * const stopTimeKey = @"stopTime";

static NSString * const stopSequenceKey = @"stopSequence";
static NSString * const stopIDKey = @"stopID";
static NSString * const routeIDKey = @"routeID";
static NSString * const serviceIDKey = @"serviceID";

@interface StopController ()

@property (atomic, strong) NSString *currentTime;
@property (atomic, strong) NSString *timePlusTwo;
@property (atomic, strong) NSArray *trips;

@property (atomic, assign) NSNumber *todayServiceID;

@end


@implementation StopController

+ (StopController *)sharedInstance {
    static StopController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StopController new];
    });
    return sharedInstance;
}

- (void)calculateRoute {
    
    self.trips = [NSArray new];
    
    [self findServiceIDForToday];
    [self timeFilterForStopTimes];
    
    [self pullStopTimesWithStopID:@18390];
    [self searchTrips];
    [self filterTrips];
    
    NSLog(@"The calculateRoute trips is: %@", self.trips);
    
}

#pragma filter trips
- (void)filterTrips {
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", serviceIDKey, self.todayServiceID];//keySelected is NSString itself
    NSLog(@"predicate %@", predicateString);
    filteredArray = [NSMutableArray arrayWithArray:[self.trips filteredArrayUsingPredicate:predicateString]];
    self.trips = filteredArray;

}

#pragma stopTimes Search
- (void)pullStopTimesWithStopID:(NSNumber *) stopID {

    PFQuery *stopTimesQuery = [PFQuery queryWithClassName:@"stop_times"];
    
    [stopTimesQuery whereKey:@"stop_id" equalTo:stopID];
    [stopTimesQuery whereKey:@"departure_time" greaterThanOrEqualTo:self.currentTime];
    [stopTimesQuery whereKey:@"arrival_time" lessThanOrEqualTo:self.timePlusTwo];
    [stopTimesQuery setLimit:1000];
    [stopTimesQuery selectKeys:@[@"trip_id", @"stop_id", @"departure_time"]];

    NSArray *objectsArray = [NSArray new];
    objectsArray = [stopTimesQuery findObjects];
    
    for (PFObject *pfObject in objectsArray) {
        [self addToDictionaryWithStopTime:pfObject[@"departure_time"] tripID:pfObject[@"trip_id"] stopID:pfObject[@"stop_id"]];
    }
}


- (void)addToDictionaryWithStopTime:(NSString *)time tripID:(NSString *)tripID stopID:(NSString *)stopID{
    
    NSMutableDictionary *tempDictionary = [NSMutableDictionary new];
    [tempDictionary setValue:tripID forKey:tripIDKey];
    [tempDictionary setValue:time forKey:stopTimeKey];
    [tempDictionary setValue:stopID forKey:stopIDKey];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.trips];
    [tempArray addObject:tempDictionary];
    self.trips = tempArray;
}


- (void)timeFilterForStopTimes {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"HH:mm:ss"; // Date formatter
    
    NSString *timeString = [dateformatter stringFromDate:[NSDate date]]; // Convert date to string
    self.currentTime = timeString;
    //    NSLog(@"%@", timeString);
    
    
    NSDate *myDate = [NSDate date];
    double secondsInTwoHours = 2 * 60 * 60;
    NSTimeInterval  interval = secondsInTwoHours;
    NSDate *timeTwoHoursAhead = [myDate dateByAddingTimeInterval:interval];
    NSString *string = [dateformatter stringFromDate:timeTwoHoursAhead];
    self.timePlusTwo = string;
    //    NSLog(@"%@", string);
    
}

#pragma trips Search
- (void)searchTrips
{
    
    for (NSDictionary *dictionary in self.trips)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"trips"];
        NSString *string = [dictionary valueForKey:tripIDKey];
        [query whereKey:@"trip_id" equalTo:string];
        [query selectKeys:@[@"route_id",@"service_id"]];
        [query setLimit:1000];
        
        NSArray *objectsArray = [[NSArray alloc] initWithArray:[query findObjects]];
        for (PFObject *pfObject in objectsArray)
        {
            [self addToDictionaryWithDictionary:dictionary Route:pfObject[@"route_id"] service:pfObject[@"service_id"]];
        }
    }
}


- (void)addToDictionaryWithDictionary:(NSDictionary *)dictionary Route:(NSString *)routeID service:(NSString *)serviceID {
        [dictionary setValue:routeID forKey:routeIDKey];
        [dictionary setValue:serviceID forKey:serviceIDKey];
}


#pragma serviceIDs for the week
- (void)findServiceIDForToday {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
//    NSArray *daysOfWeek = @[@"",@"Sun",@"Mon",@"Tue",@"Wed",@"Thur",@"Fri",@"Sat"];
    [nowDateFormatter setDateFormat:@"e"];
    NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:today] integerValue];
//    NSLog(@"Day of Week: %@ or: %ld",[daysOfWeek objectAtIndex:weekdayNumber], (long)weekdayNumber);
    
    if (weekdayNumber >= 2 && weekdayNumber <= 6) {    //Week days
        self.todayServiceID = @4;
    }
    
    if (weekdayNumber == 1) {  //Sunday
        self.todayServiceID = @3;
    }
    
    if (weekdayNumber == 7) { //Saturday
        self.todayServiceID = @2;
    }
    
//    NSLog(@"%ld", (long)self.todayServiceID);
}


@end














