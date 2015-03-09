//
//  StopController.m
//  GetMeUTA
//
//  Created by Taylor Mott on 8.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "StopController.h"
#import "Stop.h"
#import "Stack.h"
@import CoreData;

@implementation StopController

+ (StopController *)sharedInstance {
    static StopController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StopController new];
    });
    
    return sharedInstance;
}

- (NSArray *)stopsWithName:(NSString *)name
{
#warning Implement this method
    return nil;
}

- (void)addStopWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary
{
    Stop *stop = [NSEntityDescription insertNewObjectForEntityForName:@"Stop" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    stop.idString = [dictionary objectForKey:@"stop_id"];
    stop.latitude = [dictionary objectForKey:@"stop_lat"];
    stop.longitude = [dictionary objectForKey:@"stop_lon"];
    stop.name = [dictionary objectForKey:@"stop_name"];
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

@end
