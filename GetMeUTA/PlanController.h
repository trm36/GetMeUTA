//
//  PlanController.h
//  GetMeUTA
//
//  Created by Julien Guanzon on 3/19/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanController : NSObject

- (void)searchStationsForName;
@property (nonatomic, strong) NSArray* stationsList;

@end
