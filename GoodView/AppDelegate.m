//
//  AppDelegate.m
//  GoodView
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TabbarViewController * tabbarController = [[TabbarViewController alloc] init];
//    HomeViewController * homeVC = [[HomeViewController alloc]init];
//    homeVC.tabBarItem.title= @"首页";
//    homeVC.tabBarItem.image= [UIImage imageNamed:@"home_black.png"];
//    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_green.png"];
//    MyViewController * myVC = [[MyViewController alloc]init];
//    myVC.tabBarItem.title = @"我的";
//    myVC.tabBarItem.image = [UIImage imageNamed:@"me_black.png"];
//    myVC.tabBarItem.selectedImage = [UIImage imageNamed:@"me_green.png"];
//    tabbarController.viewControllers=@[homeVC,myVC];
//    tabbarController.selectedIndex = 0;
    self.window.rootViewController = tabbarController;
    
    return YES;
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
