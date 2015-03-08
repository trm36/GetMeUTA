//
//  AppDelegate.m
//  GetMeUTA
//
//  Created by Taylor Mott on 6.3.2015.
//  Copyright (c) 2015 Shelley-Guanzon-Henrie-Mott. All rights reserved.
//

#import "AppDelegate.h"
#import "CHCSVParser.h"

@interface AppDelegate () <CHCSVParserDelegate> {
    NSMutableArray * currentRow;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURL *csvurl = [[NSBundle mainBundle] URLForResource:@"stops" withExtension:@"csv"];
    
    CHCSVParser *p = [[CHCSVParser alloc] initWithContentsOfCSVURL:csvurl];
    p.delegate = self;
    [p parse];

    
    
//    NSURL *url = [NSURL fileURLWithPath:@"stops.csv"];
//    
//    CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVURL:url];
//    parser.delegate = self;
//    [parser parse];
    
//    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:@"stops.csv"];
//    CHCSVParser *p = [[CHCSVParser alloc] initWithInputStream:inputStream usedEncoding:nil delimiter:COMMA];
//    p.delegate = self;
//    [p parse];

    
//    NSArray *rows = [NSArray arrayWithContentsOfCSVURL:csvurl];
//    NSLog(@"%@", rows);

//    CHCSVParser *parser = [[CHCSVParser alloc] initWithCSVString:@"taylor,cal,ross,wagner"];
//    parser.delegate = self;
//    
//    [parser parse];
    return YES;
}

#pragma mark - CHCSVParser Delegate Methods

-(void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    currentRow = [NSMutableArray new];
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    [currentRow addObject:field];
    NSLog(@"FIELD: %@", field);
}

-(void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber
{
    NSLog(@"finished line! %lu", (unsigned long)recordNumber);
    NSLog(@"%@", currentRow);
    currentRow = nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
