//
//  TripController.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/19/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripController : NSObject

@property (nonatomic, strong) NSArray *timesForSelectedTrip;

- (void)stopTimeSearchWithTripID:(NSString *)tripID;

@end
