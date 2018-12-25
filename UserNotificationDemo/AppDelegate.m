//
//  AppDelegate.m
//  UserNotificationDemo
//
//  Created by jinren on 12/12/18.
//  Copyright © 2018 jinren. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"request Auth");
    }];
    UNNotificationAction* acceptCall = [UNNotificationAction actionWithIdentifier:@"Accept_Call" title:@"Accept Call" options:UNNotificationActionOptionForeground];
    UNNotificationAction* declineCall = [UNNotificationAction actionWithIdentifier:@"Decline_Call" title:@"decline_Call" options:UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction* inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"Reply_Text" title:@"Reply" options:UNNotificationActionOptionNone textInputButtonTitle:@"Send" textInputPlaceholder:@"input your text message"];
    
    UNNotificationCategory* callCat = [UNNotificationCategory categoryWithIdentifier:@"Call_Cate" actions:@[acceptCall, declineCall, inputAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:callCat]];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    if ([response.actionIdentifier isEqualToString:@"Reply_Text"]) {
        UNTextInputNotificationResponse* textInput = response;
        NSLog(@"user click %@ , text: %@", response.actionIdentifier, textInput.userText);
    } else {
        NSLog(@"user click %@ call", response.actionIdentifier);
    }
    
    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
