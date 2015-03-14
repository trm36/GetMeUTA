//
//  ButtonController.h
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Button;

@interface ButtonController : NSObject

@property (nonatomic , strong, readonly)NSArray * buttons;

+ (ButtonController *)sharedInstance;
- (void)addButton:(Button *)button;
- (void)removeButton:(Button *)button;
- (void)replaceButton:(Button *)oldButton withButton:(Button *)newButton;
//- (void)replaceButtonAtIndex:(int)oldButtonIndex withButton:(Button *)newButton;
- (void)loadFromDefaults;
- (void)synchronize;

@end