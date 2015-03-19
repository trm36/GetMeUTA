//
//  StopController.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopController : NSObject

@property (atomic, readonly) NSArray *trips;

- (void)getStopDataWithStopID:(NSNumber *)stopID;
- (void)removeRoute:(NSArray *)route;
- (void)removeMissedTrips:(NSArray *)trip;

@end
