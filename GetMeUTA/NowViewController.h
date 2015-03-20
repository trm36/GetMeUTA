//
//  ViewController.h
//  GetMeUTA
//
//  Created by Paul Shelley on 3/10/15.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NowViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

@end

