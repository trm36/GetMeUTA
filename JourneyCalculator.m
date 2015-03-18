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
    [startStation getStopDataWithStopID:@18409];
    
    StopController *endStation = [StopController new];
    [endStation getStopDataWithStopID:@18389];
    
    [self commonRoutsWithStartStation:startStation andEndStation:endStation];
}

+ (NSMutableSet *)commonRoutsWithStartStation:(StopController *)startStation andEndStation:(StopController *)endStation{
    NSMutableSet *startSet = [[NSMutableSet alloc] initWithArray:[startStation.trips valueForKey:routeIDKey]];
    NSSet *endSet = [[NSMutableSet alloc] initWithArray:[endStation.trips valueForKey:routeIDKey]];
    [startSet intersectSet:endSet];
    NSLog(@"Routes Array: %@", startSet);
    return startSet;
}

@end





