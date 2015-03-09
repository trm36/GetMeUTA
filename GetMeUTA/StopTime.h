//
//  StopTime.h
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stop, Trip;

@interface StopTime : NSManagedObject

@property (nonatomic, retain) NSString * arrivalTime;
@property (nonatomic, retain) NSString * departureTime;
@property (nonatomic, retain) NSString * stopSequence;
@property (nonatomic, retain) Stop *stop;
@property (nonatomic, retain) Trip *trip;

@end
