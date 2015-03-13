//
//  Button.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "Button.h"

@implementation Button

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[titleKey];
        self.station = dictionary[stationKey];
        self.needsSettup = dictionary[needsSettupKey];
    }
    return self;
}

- (NSDictionary *)buttonDictionary {
    
    NSMutableDictionary *buttonDictionary = [NSMutableDictionary new];
    if (self.title) {
        [buttonDictionary setObject:self.title forKey:titleKey];
    }
    if (self.station) {
        [buttonDictionary setObject:self.station forKey:stationKey];
    }
    if (self.needsSettup) {
        [buttonDictionary setObject:self.needsSettup forKey:needsSettupKey];
    }
    
    return buttonDictionary;
    
}

@end