//
//  Calendar.h
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Calendar : NSManagedObject

@property (nonatomic, retain) NSString * serviceID;
@property (nonatomic, retain) NSString * monday;
@property (nonatomic, retain) NSString * tuesday;
@property (nonatomic, retain) NSString * wednesday;
@property (nonatomic, retain) NSString * thursday;
@property (nonatomic, retain) NSString * friday;
@property (nonatomic, retain) NSString * saturday;
@property (nonatomic, retain) NSString * sunday;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;


@end
