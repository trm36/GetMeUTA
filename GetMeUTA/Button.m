//
//  Button.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "Button.h"

//static NSString * const entriesKey = @"entries";

@implementation Button

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[titleKey];
        self.action = dictionary[actionKey];
        self.station = dictionary[stationKey];
    }
    return self;
}

- (NSDictionary *)buttonDictionary {
    
    NSMutableDictionary *buttonDictionary = [NSMutableDictionary new];
    if (self.title) {
        [buttonDictionary setObject:self.title forKey:titleKey];
    }
    if (self.action) {
        [buttonDictionary setObject:self.action forKey:actionKey];
    }
    if (self.station) {
        [buttonDictionary setObject:self.station forKey:stationKey];
    }
    
    return buttonDictionary;
    
}



@end