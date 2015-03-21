//
//  Button.h
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const titleKey = @"title";
static NSString * const stationIDKey = @"stationID";
static NSString * const needsSettupKey = @"needsSettup";

@interface Button : NSObject <NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *stationID;
@property (nonatomic, copy) NSString *needsSettup;

@end
