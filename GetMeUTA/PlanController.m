//
//  PlanController.m
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/19/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "PlanController.h"
#import <Parse/Parse.h>

static NSString * const stopIDKey = @"stopID";
static NSString * const stopNameKey = @"stopName";

@implementation PlanController

+ (PlanController *)sharedInstance {
    static PlanController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PlanController new];
    });
    return sharedInstance;
}

- (void)searchStationsForName {
    
    PFQuery *stationsQuery = [PFQuery queryWithClassName:@"singleStations"];
    [stationsQuery selectKeys:@[@"stop_id", @"stop_name"]];
    [stationsQuery orderByAscending:@"stop_name"];
    NSArray *stationsArray = [[NSArray alloc] initWithArray:[stationsQuery findObjects]];
    for (PFObject *pfObject in stationsArray) {
        [self addToDictionaryStopID:pfObject[@"stop_id"] stopName:pfObject[@"stop_name"]];
    }
//    NSLog(@"%@", self.stationsList);
}


- (void)addToDictionaryStopID:(NSString *)stopID stopName:(NSString *)stopName {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setValue:stopID forKey:stopIDKey];
    [dictionary setValue:stopName forKey:stopNameKey];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.stationsList];
    [tempArray addObject:dictionary];
    self.stationsList = tempArray;
}

@end
