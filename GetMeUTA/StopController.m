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

@interface StopController ()

@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, strong) NSArray *trips;

@end


@implementation StopController

+ (StopController *)sharedInstance {
    static StopController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StopController new];
        sharedInstance.trips = [NSArray new];
    });
    return sharedInstance;
}

- (void)pullStopTimesWithStopID:(NSNumber *) stopID {
    
    [self convertCurrentTimeFormat];
    
    PFQuery *stopTimesQuery = [PFQuery queryWithClassName:@"stop_times" ];
    
    [stopTimesQuery whereKey:@"stop_id" equalTo:stopID];
    [stopTimesQuery whereKey:@"departure_time" greaterThanOrEqualTo:self.currentTime];
    [stopTimesQuery whereKey:@"arrival_time" lessThanOrEqualTo:@"24:00:00"];
    [stopTimesQuery setLimit:1000];
    [stopTimesQuery selectKeys:@[@"trip_id", @"stop_id", @"departure_time"]];
    
    [stopTimesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *pfObject in objects) {
//                NSLog(@"%@ %@ %@", pfObject[@"trip_id"], pfObject[@"departure_time"], pfObject[@"stop_id"]); //test call to each pfobject queried
                [self addToDictionaryWithStopTime:pfObject[@"departure_time"] tripID:pfObject[@"trip_id"] stopID:pfObject[@"stop_id"]];
            }
//            NSLog(@"%@", self.trips); //check trips array of dictionaries
        } else {
            NSLog(@"failed to retrieve from stopTimes");
        }
    }];
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


- (void)convertCurrentTimeFormat {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"HH:mm:ss"; // Date formatter
    NSString *timeString = [dateformatter stringFromDate:[NSDate date]]; // Convert date to string
    self.currentTime = timeString;
}




@end
