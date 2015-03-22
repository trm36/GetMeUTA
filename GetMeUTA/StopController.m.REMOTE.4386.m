//
//  StopController.m
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "StopController.h"
#import <Parse/Parse.h>

static NSString * const tripIDKey = @"tripID";
static NSString * const stopTimeKey = @"stopTime";
static NSString * const stopIDKey = @"stopID";
static NSString * const routeIDKey = @"routeID";
static NSString * const serviceIDKey = @"serviceID";
static NSString * const stopNameKey = @"stopName";

@interface StopController ()

@property (atomic, strong) NSString *currentTime;
@property (atomic, strong) NSString *timePlusTwo;
//@property (atomic, strong) NSArray *trips;
@property (atomic, assign) NSString *todayServiceID;

@end


@implementation StopController

- (void)getStopDataWithStopID:(NSString *)stopID {
    
    self.trips = [NSArray new];
    [self findServiceIDForToday];
    [self timeFilterForStopTimes];
    
    NSArray *stops = [self searchDuplicateStopsWithStopID:stopID];
    for (NSNumber *stop in stops) {
        [self pullStopTimesWithStopID:stop];
    }
    
    [self searchTrips];
    [self filterTrips];
//
    NSLog(@"The calculateRoute trips is: %@", self.trips);
}

#pragma convert time to NSDate
- (NSDate *)convertTimeToNSDate:(NSString *)time {
    //Gets current month day and year
    NSDateFormatter *monthDayYear = [[NSDateFormatter alloc] init];
    [monthDayYear setDateFormat:@"yyyy-MM-dd"];
    NSString *stringNewDate = [monthDayYear stringFromDate:[NSDate date]];
    
    //Adds the two strings togeather
    stringNewDate = [stringNewDate stringByAppendingString:@" "];
    stringNewDate = [stringNewDate stringByAppendingString:time];
//    NSLog(@"Stop String: %@", stringNewDate);
    
    //Converts NewDate string to an NSDate (GMT)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:stringNewDate];
//    NSLog(@"New Date: %@", dateFromString);
    
    return dateFromString;
}

#pragma remove routes
- (void)removeRoute:(NSArray *)route {
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    
    for (int i = 0; i < self.trips.count; i++) {
        
        for (int x = 0; x < route.count; x++) {
            
            if (self.trips[i][routeIDKey] == route[x]) {
                [filteredArray addObject:self.trips[i]];
            }
        }
    }
    
    self.trips = filteredArray;
}

#pragma missed trips
- (void)removeMissedTrips:(NSArray *)trip {
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    
    for (int i = 0; i < self.trips.count; i++) {
        
        for (int x = 0; x < trip.count; x++) {
            
            if (self.trips[i][tripIDKey] == trip[x]) {
                [filteredArray addObject:self.trips[i]];
            }
        }
    }
    
    self.trips = filteredArray;
}

#pragma stops Search Duplicates
- (NSArray *)searchDuplicateStopsWithStopID:(NSString *)stopID {
    
    NSString *stopName = [NSString new];

    PFQuery *stopIDQuery = [PFQuery queryWithClassName:@"stations"];
    [stopIDQuery whereKey:@"stop_id" equalTo:stopID];
    [stopIDQuery selectKeys:@[@"stop_name"]];
    
    NSArray *objectsIDArray = [[NSArray alloc] initWithArray:[stopIDQuery findObjects]];
    
    for (PFObject *pfObject in objectsIDArray) {
        
        stopName =pfObject[@"stop_name"];
//        NSLog(@"%@", pfObject[@"stop_name"]);
    }
    
    PFQuery *stopNameQuery = [PFQuery queryWithClassName:@"stations"];
    [stopNameQuery whereKey:@"stop_name" equalTo:stopName];
    
    NSArray *objectsNameArray = [[NSArray alloc] initWithArray:[stopNameQuery findObjects]];
    
    NSMutableArray *stopIDArray = [NSMutableArray new];
    for (PFObject *pfObject in objectsNameArray) {
        [stopIDArray addObject:pfObject[@"stop_id"]];
//        NSLog(@"%@", stopIDArray);
    }
    return stopIDArray;
    
}


#pragma stopTimes Search
- (void)pullStopTimesWithStopID:(NSNumber *) stopID {

    PFQuery *stopTimesQuery = [PFQuery queryWithClassName:@"ltd_stop_times"];
    
    [stopTimesQuery whereKey:@"stop_id" equalTo:stopID];
    [stopTimesQuery whereKey:@"departure_time" greaterThanOrEqualTo:self.currentTime];
    [stopTimesQuery whereKey:@"departure_time" lessThanOrEqualTo:self.timePlusTwo];
    [stopTimesQuery setLimit:1000];
    [stopTimesQuery selectKeys:@[@"trip_id", @"stop_id", @"departure_time"]];

    NSArray *objectsArray = [NSArray new];
    objectsArray = [stopTimesQuery findObjects];
    
    for (PFObject *pfObject in objectsArray) {
        
        NSDate *date = [self convertTimeToNSDate:pfObject[@"departure_time"]];
        
        [self addToDictionaryWithStopTime:date tripID:pfObject[@"trip_id"] stopID:pfObject[@"stop_id"]];
    }
}


- (void)addToDictionaryWithStopTime:(NSDate *)time tripID:(NSString *)tripID stopID:(NSString *)stopID{
    
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
        PFQuery *query = [PFQuery queryWithClassName:@"ltd_trips"];
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
        self.todayServiceID = @"4";
    }
    
    if (weekdayNumber == 1) {  //Sunday
        self.todayServiceID = @"3";
    }
    
    if (weekdayNumber == 7) { //Saturday
        self.todayServiceID = @"2";
    }
    
//    NSLog(@"%ld", (long)self.todayServiceID);
}



#pragma filter trips
- (void)filterTrips {
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", serviceIDKey, self.todayServiceID];
//    NSLog(@"predicate %@", predicateString);
    filteredArray = [NSMutableArray arrayWithArray:[self.trips filteredArrayUsingPredicate:predicateString]];
    self.trips = filteredArray;
}


@end














