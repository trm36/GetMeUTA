//
//  Button.h
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const titleKey = @"title";
static NSString * const stationKey = @"station";
static NSString * const needsSettupKey = @"needsSettup";

@interface Button : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *station;
@property (nonatomic, assign) NSString *needsSettup;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)buttonDictionary;



@end
