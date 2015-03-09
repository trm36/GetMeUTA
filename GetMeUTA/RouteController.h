//
//  RouteController.h
//  GetMeUTA
//
//  Created by Taylor Mott on 9.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface RouteController : NSObject

+ (RouteController *)sharedInstance;
- (void)addRouteWithCHCSVOrderedDictionary:(CHCSVOrderedDictionary *)dictionary;

@end
