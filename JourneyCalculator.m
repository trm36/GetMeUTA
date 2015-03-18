//
//  JourneyCalculator.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/18/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "JourneyCalculator.h"
#import "StopController.h"

@implementation JourneyCalculator


+ (void)calculateJourney {
    StopController *endStation = [StopController new];
    [endStation getStopDataWithStopID:@23080];
}

@end
