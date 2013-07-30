//
//  YELAppDelegate.m
//  Alarm
//
//  Created by rock on 13-7-17.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELAppDelegate.h"
#import "ETNavigationViewController.h"
#import "YELViewController.h"

@implementation YELAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    YELViewController *yelViewcontroller= [[YELViewController alloc] initWithNibName:@"YELViewController" bundle:nil];
    ETNavigationViewController *navigationController=[[ETNavigationViewController alloc]initWithRootViewController:yelViewcontroller];
    NSString *pwd=[USER_DEFAULT objectForKey:PWD];
    if(pwd!=nil) {
        [yelViewcontroller sendRequest:pwd luanch:NO];
    }
     [NSThread sleepForTimeInterval:2.0];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    //推送的形式：标记，声音，提示
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];

    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken
{
    NSString *deviceTokenString=[NSString stringWithFormat:@"%@",pToken];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [USER_DEFAULT setObject:deviceTokenString forKey:@"deviceToken"];
    [USER_DEFAULT synchronize];
    //注册成功，将deviceToken保存到应用服务器数据库中
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    NSLog(@"userinfo:%@",userInfo);
    
    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Registfail%@",error);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
