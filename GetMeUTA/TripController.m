//
//  TripController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "TripController.h"
#import "Route.h"
#import "Stack.h"
#import "Trip.h"
@import CoreData;

@implementation TripController

+ (TripController *)sharedInstance {
    static TripController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TripController new];
    });
    
    return sharedInstance;
}

- (void)addTripWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary
{
    Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    trip.headSign = [dictionary objectForKey:@"trip_headsign"];
    trip.idString = [dictionary objectForKey:@"trip_id"];
    trip.serviceID = [dictionary objectForKey:@"service_id"];
    
    NSPredicate *routePredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"idString == %@", [dictionary objectForKey:@"route_id"]]];
    NSFetchRequest *routeFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Route"];
    [routeFetchRequest setPredicate:routePredicate];
    
    NSArray *matchingRoutes = [[Stack sharedInstance].managedObjectContext executeFetchRequest:routeFetchRequest error:NULL];
    
    if (matchingRoutes.firstObject) {
        trip.route = matchingRoutes.firstObject;
    }
}

@end
