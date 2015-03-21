//
//  ButtonController.m
//  GetMeUTA
//
//  Created by Paul Shelley on 3/12/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "ButtonController.h"
#import "Button.h"

static NSString *launchKey = @"launch";
static NSString * const buttonListKey = @"listOfButtons";

@interface ButtonController ()

@property (nonatomic, strong) NSArray *buttons;

@end

@implementation ButtonController

+ (ButtonController *)sharedInstance {
    static ButtonController *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ButtonController alloc] init];
        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:buttonListKey];
//        return;
        
        NSArray *buttonDatas = [[NSUserDefaults standardUserDefaults] objectForKey:buttonListKey];
        if (!buttonDatas) {
            sharedInstance.buttons = @[[self defaultButton]];
            [sharedInstance synchronize];
        } else {
            [sharedInstance loadFromDefaults];
        }
        
    });
    
    return sharedInstance;
}

+ (Button *)defaultButton {
    Button *defaultButton = [[Button alloc] init];
    defaultButton.title = @"home";
    defaultButton.stationID = nil;
    defaultButton.needsSettup = @"YES";
    
    return defaultButton;
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
    
    NSMutableArray *mutableButtons = self.buttons.mutableCopy;
    [mutableButtons removeObject:button];
    
    self.buttons = mutableButtons;
    [self synchronize];
    
}

- (void)replaceButton:(Button *)oldButton withButton:(Button *)newButton {
    
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
    
    NSArray *buttonDatas = [[NSUserDefaults standardUserDefaults] objectForKey:buttonListKey];
    
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSData *buttonData in buttonDatas) {
        Button *button = [NSKeyedUnarchiver unarchiveObjectWithData:buttonData];
        [buttons addObject:button];
    }
    
    self.buttons = buttons;
    
}

- (void)synchronize {
    
    NSMutableArray *buttons = [NSMutableArray array];
    for (Button *button in self.buttons) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:button];
        [buttons addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:buttons forKey:buttonListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
