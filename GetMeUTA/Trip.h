//
//  Trip.h
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Route, StopTime;

@interface Trip : NSManagedObject

@property (nonatomic, retain) NSString * headSign;
@property (nonatomic, retain) NSString * idString;
@property (nonatomic, retain) NSString * serviceID;
@property (nonatomic, retain) Route *route;
@property (nonatomic, retain) NSSet *stopTimes;
@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addStopTimesObject:(StopTime *)value;
- (void)removeStopTimesObject:(StopTime *)value;
- (void)addStopTimes:(NSSet *)values;
- (void)removeStopTimes:(NSSet *)values;

@end
