//
//  Button.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "Button.h"

@implementation Button

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:titleKey];
        self.stationID = [aDecoder decodeObjectForKey:stationIDKey];
        self.needsSettup = [aDecoder decodeObjectForKey:needsSettupKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:titleKey];
    [aCoder encodeObject:self.stationID forKey:stationIDKey];
    [aCoder encodeObject:@"YES" forKey:needsSettupKey];
    
    if (self.title) {
        [aCoder encodeObject:self.title forKey:titleKey];
        [aCoder encodeObject:@"NO" forKey:needsSettupKey];
    }
    if (self.stationID) {
        [aCoder encodeObject:self.stationID forKey:stationIDKey];
        [aCoder encodeObject:@"NO" forKey:needsSettupKey];
    }
    if (!self.title) {
        [aCoder encodeObject:@"YES" forKey:needsSettupKey];
    }
    if (!self.stationID) {
        [aCoder encodeObject:@"YES" forKey:needsSettupKey];
    }
    
}

@end