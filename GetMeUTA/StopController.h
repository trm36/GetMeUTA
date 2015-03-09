//
//  StopController.h
//  GetMeUTA
//
//  Created by Taylor Mott on 8.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface StopController : NSObject


+ (StopController *)sharedInstance;
- (NSArray *)stopsWithName:(NSString *)name;
- (void)addStopWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary;

@end
