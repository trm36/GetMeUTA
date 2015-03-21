//
//  StopController.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopController : NSObject

@property (atomic, readwrite) NSArray *trips;

- (void)getStopDataWithStopName:(NSString *)stopName;
- (void)removeRoute:(NSArray *)route;
- (void)removeMissedTrips:(NSArray *)trip;



@end
