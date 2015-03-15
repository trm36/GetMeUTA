//
//  CustomColors.m
//  GetMe
//
//  Created by Paul Shelley on 3/11/15.
//  Copyright (c) 2015 pdShelley. All rights reserved.
//

#import "NSObject+UIColor.h"

@implementation NSObject (UIColor)

- (UIColor *)randomColor {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1];
    return randomColor;
}

- (UIColor *)blue {
    UIColor *color = [UIColor colorWithRed:0.416f green:0.682f blue:0.847f alpha:1.00f];
    return color;
}

- (UIColor *)lightBlue {
    UIColor *color = [UIColor colorWithRed:0.761f green:0.859f blue:0.929f alpha:1.00f];
    return color;
}

- (UIColor *)darkBlue {
    UIColor *color = [UIColor colorWithRed:0.106f green:0.361f blue:0.541f alpha:1.00f];
    return color;
}

- (UIColor *)darkRed {
    UIColor *color = [UIColor colorWithRed:0.722f green:0.153f blue:0.196f alpha:1.00f];
    return color;
}

- (UIColor *)clearWhite {
    UIColor *color = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:0.8f];
    return color;
}



@end