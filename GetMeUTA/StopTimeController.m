//
//  StopTimeController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "StopTimeController.h"
#import "StopTime.h"
#import "Stack.h"

@implementation StopTimeController

+ (StopTimeController *)sharedInstance {
    static StopTimeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StopTimeController new];
    });
    
    return sharedInstance;
}

-(void)addStopTimeWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary
{
    StopTime *stopTime = [NSEntityDescription insertNewObjectForEntityForName:@"StopTime" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    stopTime.arrivalTime = [dictionary objectForKey:@"arrival_time"];
    stopTime.departureTime = [dictionary objectForKey:@"departure_time"];
    stopTime.stopSequence = [dictionary objectForKey:@"stop_sequence"];
    
    NSPredicate *stopPredicate = [NSPredicate predicateWithFormat:@"idString == %@", [dictionary objectForKey:@"stop_id"]];
    NSFetchRequest *stopFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Stop"];
    [stopFetchRequest setPredicate:stopPredicate];
    
    NSArray *matchingStops = [[Stack sharedInstance].managedObjectContext executeFetchRequest:stopFetchRequest error:NULL];
    
    if (matchingStops.firstObject) {
        stopTime.stop = matchingStops.firstObject;
    }
    
    NSPredicate *tripPredicate = [NSPredicate predicateWithFormat:@"idString == %@", [dictionary objectForKey:@"trip_id"]];
    NSFetchRequest *tripFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
    [tripFetchRequest setPredicate:tripPredicate];
    
    NSArray *matchingTrips = [[Stack sharedInstance].managedObjectContext executeFetchRequest:tripFetchRequest error:NULL];
    
    if (matchingTrips.firstObject) {
        stopTime.trip = matchingTrips.firstObject;
    }
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

@end
