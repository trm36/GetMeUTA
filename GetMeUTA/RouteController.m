//
//  RouteController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "RouteController.h"
#import "Route.h"
#import "Stack.h"
@import CoreData;

@implementation RouteController

+ (RouteController *)sharedInstance {
    static RouteController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RouteController new];
    });
    
    return sharedInstance;
}

- (void)addRouteWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary
{
    Route *route = [NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    route.idString = [dictionary objectForKey:@"route_id"];
    route.color = [dictionary objectForKey:@"route_color"];
    route.longName = [dictionary objectForKey:@"route_long_name"];
    route.shortName = [dictionary objectForKey:@"route_short_name"];
    route.textColor = [dictionary objectForKey:@"route_text_color"];
    route.type = [dictionary objectForKey:@"route_color"];
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

@end
