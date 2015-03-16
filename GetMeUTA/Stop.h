//
//  Stop.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/14/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stop : NSObject

@property (nonatomic, strong) NSString *stopID;
@property (nonatomic, strong) NSString *stopName;
@property (nonatomic, strong) NSString *stopLatitude;
@property (nonatomic, strong) NSString *stopLongitude;

@property (nonatomic, strong) NSArray *stopTimes;


@end
