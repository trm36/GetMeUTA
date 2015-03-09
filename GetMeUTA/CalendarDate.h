//
//  CalendarDate.h
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CalendarDate : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * exceptionType;
@property (nonatomic, retain) NSString * serviceID;

@end
