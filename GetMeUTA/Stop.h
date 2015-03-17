//
//  Stop.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stop : NSObject

@property (atomic, strong) NSString *stopID;
@property (atomic, strong) NSString *stopName;
@property (atomic, strong) NSString *stopLatitude;
@property (atomic, strong) NSString *stopLongitude;

@property (atomic, strong) NSArray *stopTimes;


@end
