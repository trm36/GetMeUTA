//
//  TripController.m
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/19/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "TripController.h"
#import <Parse/Parse.h>


static NSString * const tripTimesKey = @"tripTime";
static NSString * const stopIDKey = @"stopID";
static NSString * const tripIDKey = @"tripID";
static NSString * const stopSequenceKey = @"stopSequence";
static NSString * const stopNameKey = @"stopName";

@implementation TripController


#pragma stopTimes search with TRIPID
- (void)stopTimeSearchWithTripID:(NSNumber *)tripID {
    PFQuery *timesQuery = [PFQuery queryWithClassName:@"stop_times"];
    [timesQuery whereKey:@"trip_id" equalTo:tripID];
    [timesQuery selectKeys:@[@"departure_time", @"stop_id", @"stop_sequence", @"trip_id",]];
    NSArray *timesArray = [[NSArray alloc] initWithArray:[timesQuery findObjects]];
    for (PFObject *timesObject in timesArray) {
        [self addToDictionaryStopTimes:timesObject[@"departure_time"] stopID:timesObject[@"stop_id"] stopSequence:timesObject[@"stop_sequence"] forTrip:timesObject[@"trip_id"]];
    }
}

-(void)addToDictionaryStopTimes:(NSString *)times stopID:(NSString *)stopID stopSequence:(NSString *)stopSequence forTrip:(NSString *)tripID {
    
    NSMutableDictionary *stopTimesDictionary = [NSMutableDictionary new];
    [stopTimesDictionary setValue:times forKey:tripTimesKey];
    [stopTimesDictionary setValue:stopID forKey:stopIDKey];
    [stopTimesDictionary setValue:tripID forKey:tripIDKey];
    [stopTimesDictionary setValue:stopSequence forKey:stopSequenceKey];
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.timesForSelectedTrip];
    [tempArray addObject:stopTimesDictionary];
    self.timesForSelectedTrip = tempArray;
}

#pragma stopName search

-(void)pullStopNamesForTrips {
    
    for (NSDictionary *dictionary in self.timesForSelectedTrip) {
        NSString *stopID = [dictionary valueForKey:stopIDKey];
        
        PFQuery *stopsQuery = [PFQuery queryWithClassName:@"stations"];
        [stopsQuery whereKey:@"stop_id" equalTo:stopID];
        [stopsQuery selectKeys:@[@"stop_name"]];
        NSArray *stopNamesArray = [[NSArray alloc] initWithArray:[stopsQuery findObjects]];
        for (PFObject *pfObject in stopNamesArray) {
            [self addToDictionary:dictionary stopNames:pfObject[@"stop_name"]];
        }
    }
    
}

-(void)addToDictionary:(NSDictionary *)dictionary stopNames:(NSString *)stopName {
    [dictionary setValue:stopName forKey:stopNameKey];
}

@end





