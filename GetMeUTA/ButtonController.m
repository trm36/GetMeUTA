//
//  ButtonController.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "ButtonController.h"

static NSString * const buttonListKey = @"buttonList";

@interface ButtonController ()

@property (nonatomic, strong) NSArray *buttons;

@end

@implementation ButtonController

+ (ButtonController *)sharedInstance {
    static ButtonController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ButtonController alloc] init];
    });
    return sharedInstance;
}

- (void)addButton:(Button *)button {
    
    if (!self) {
        return;
    }
    
    NSMutableArray *mutableButtons = self.buttons.mutableCopy;
    [mutableButtons addObject:button];
    
    self.buttons = mutableButtons;
    [self synchronize];
    
}

- (void)removeButton:(Button *)button {
    
    if (!self) {
        return;
    }
    
    NSMutableArray *mutableButtons = self.entries.mutableCopy;
    [mutableButtons removeObject:button];
    
    self.buttons = mutableButtons;
    [self synchronize];
    
}

- (void)replaceButton:(NSDictionary *)oldButton withButton:(NSDictionary *)newButton {
    
    if (!oldButton || !newButton) {
        return;
    }
    
    NSMutableArray *mutableButtons = self.buttons.mutableCopy;
    
    if ([mutableButtons containsObject:oldButton]) {
        NSInteger index = [mutableButtons indexOfObject:oldButton];
        [mutableButtons replaceObjectAtIndex:index withObject:newButton];
    }
    
    self.buttons = mutableButtons;
    [self synchronize];
    
}

- (void)loadFromDefaults {
    
    NSArray *buttonDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:buttonListKey];
    
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSDictionary *button in buttonDictionaries) {
        [buttons addObject:[[Button alloc] initWithDictionary:button]];
    }
    
    self.buttons = buttons;
    
}

- (void)synchronize {
    NSMutableArray *buttonDictionaries = [NSMutableArray new];
    for (Button *button in self.buttons) {
        [buttonDictionaries addObject:[button buttonDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:buttonDictionaries forKey:buttonListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end




