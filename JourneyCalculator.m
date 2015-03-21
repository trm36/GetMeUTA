//
//  JourneyCalculator.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/18/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "JourneyCalculator.h"
#import "StopController.h"

static NSString * const tripIDKey = @"tripID";
static NSString * const stopTimeKey = @"stopTime";
static NSString * const stopIDKey = @"stopID";
static NSString * const routeIDKey = @"routeID";
static NSString * const serviceIDKey = @"serviceID";
static NSString * const stopNameKey = @"stopName";

@implementation JourneyCalculator


+ (void)calculateJourney {
    StopController *startStation = [StopController new];
    [startStation getStopDataWithStopID:@18393];
    
    StopController *endStation = [StopController new];
    [endStation getStopDataWithStopID:@23565];
    
    NSArray *routes = [self commonRoutsWithStartStation:startStation andEndStation:endStation];
    [startStation removeRoute:routes];
    [endStation removeRoute:routes];
    
//    NSArray *trips = [self filterMissedTripsWithStartStation:startStation andEndStation:endStation];
//    [endStation removeMissedTrips:trips];
//    [startStation removeMissedTrips:trips];
    
//    [self directionFilterForStartStation:startStation andEndStation:endStation];
//    [self directionFilterForStartStation:endStation andEndStation:startStation];
    
    NSLog(@"startStation Object: %@", startStation.trips);
    NSLog(@"endStation Object: %@", endStation.trips);
    
}


//Returns routes that need to be removed from the startStations.trips
+ (NSArray *)commonRoutsWithStartStation:(StopController *)startStation andEndStation:(StopController *)endStation {
    
    NSMutableSet *startSet = [[NSMutableSet alloc] initWithArray:[startStation.trips valueForKey:routeIDKey]];
    NSSet *endSet = [[NSMutableSet alloc] initWithArray:[endStation.trips valueForKey:routeIDKey]];
    
    [startSet intersectSet:endSet];
    //NSLog(@"Routes Array: %@", startSet);
    
    NSOrderedSet *commonSet = [[NSOrderedSet alloc] initWithSet:startSet];
    NSArray *commonRoutes = [[NSArray alloc] initWithArray:[commonSet array]];
    
    return commonRoutes;
}

+ (NSArray *)filterMissedTripsWithStartStation:(StopController *)startStation andEndStation:(StopController *)endStation {
    
    NSMutableSet *startSet = [[NSMutableSet alloc] initWithArray:[startStation.trips valueForKey:tripIDKey]];
    NSSet *endSet = [[NSMutableSet alloc] initWithArray:[endStation.trips valueForKey:tripIDKey]];
    
    [startSet intersectSet:endSet];
    NSLog(@"Common Trips Array: %@", startSet);
    
    NSOrderedSet *commonSet = [[NSOrderedSet alloc] initWithSet:startSet];
    NSArray *commonTrips = [[NSArray alloc] initWithArray:[commonSet array]];
    
    return commonTrips;
}

- (void)convertStringtoDate {
    
    //string to NSDate
    //Date from string
    //Date formater
    //Sort descriptor
}

+ (void)directionFilterForStartStation:(StopController *)startStation andEndStation:(StopController *)endStation {
    //search tripID in both start and end, take the trip that endTime > startTime
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    
    //loop through endStation
    
    
    for (int i = 0; i < startStation.trips.count; i++) {
        
        for (int x = 0; x < endStation.trips.count; x++) {
            
            if (endStation.trips[x][tripIDKey] == startStation.trips[i][tripIDKey]) {
                
                if (endStation.trips[x][stopTimeKey] > startStation.trips[i][stopTimeKey]) {
                    [filteredArray addObject:startStation.trips[i]];
                }
            }
        }
    }
    
    startStation.trips = filteredArray;
    
    //For every trip search for the same trip in startStation
    //if the endStation time is greater than the startStation time then coppy dictionary to new array.
    //save the new array to self.trips
    
}


- (void)sortByTime {
    
}





@end





