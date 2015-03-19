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
    
//    NSMutableSet *startTrips = [self commonRoutsWithStartStation:startStation andEndStation:endStation];
//    for (NSNumber *number in startTrips) {
//        [startStation removeRoute:number];
//    }
//    
//    NSMutableSet *endTrips = [self commonRoutsWithStartStation:endStation andEndStation:startStation];
//    for (NSNumber *number in endTrips) {
//        [endStation removeRoute:number];
//    }
    
    NSLog(@"startStation Object: %@", startStation.trips);
    NSLog(@"endStation Object: %@", endStation.trips);
}


//Returns routes that need to be removed from the startStations.trips
+ (NSArray *)commonRoutsWithStartStation:(StopController *)startStation andEndStation:(StopController *)endStation {
    
    NSMutableSet *startSet = [[NSMutableSet alloc] initWithArray:[startStation.trips valueForKey:routeIDKey]];
    NSSet *endSet = [[NSMutableSet alloc] initWithArray:[endStation.trips valueForKey:routeIDKey]];
    
    [startSet intersectSet:endSet];
    NSLog(@"Routes Array: %@", startSet);
    
    NSOrderedSet *commonSet = [[NSOrderedSet alloc] initWithSet:startSet];
    NSArray *commonRoutes = [[NSArray alloc] initWithArray:[commonSet array]];
    
    return commonRoutes;
}

- (NSMutableSet *)filterMissedTripsWithStartStation:(StopController *)firstStation andEndStation:(StopController *)secondStation {
    
    NSMutableSet *firstSet = [[NSMutableSet alloc] initWithArray:[firstStation.trips valueForKey:tripIDKey]];
    NSSet *secondSet = [[NSMutableSet alloc] initWithArray:[secondStation.trips valueForKey:tripIDKey]];
    
    [firstSet intersectSet:secondSet];
    NSLog(@"Routes Array: %@", firstSet);
    
    NSMutableSet *subtractSet = [[NSMutableSet alloc] initWithArray:[firstStation.trips valueForKey:routeIDKey]];
    [subtractSet minusSet:firstSet];
    
    return subtractSet;
}

- (void)convertStringtoDate {
    
    //string to NSDate
    //Date from string
    //Date formater
    //Sort descriptor
}

- (void)directionFilter {
    
    //search tripID in both start and end, take the trip that endTime > startTime
}



- (void)sortByTime {
    
}





@end





