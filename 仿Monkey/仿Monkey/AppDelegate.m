//
//  AppDelegate.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/3.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
//四个模块控制器
#import "DiscoveryViewController.h"
#import "UserRankViewController.h"
#import "MoreViewController.h"
#import "RepositoriesViewController.h"

//最主要的model
#import "UserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setupTabBar];
    
    self.apiEngine = [[YiNetworkEngine alloc] initWithDefaultSet];
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

- (void)setupTabBar
{
    UserRankViewController *languageRank=[[UserRankViewController alloc] init];
    BaseNavigationController *navLanguageRank=[self initlizerNavigationControllerWithRootViewController:languageRank];
    navLanguageRank.navigationBar.barTintColor=YiBlue;
    navLanguageRank.navigationBar.tintColor=[UIColor whiteColor];
    navLanguageRank.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    RepositoriesViewController *repositories=[[RepositoriesViewController alloc] init];
    BaseNavigationController *navRepositories = [self initlizerNavigationControllerWithRootViewController:repositories];
    navRepositories.navigationBar.barTintColor=YiBlue;
    navRepositories.navigationBar.tintColor=[UIColor whiteColor];
    navRepositories.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    DiscoveryViewController *discovery=[[DiscoveryViewController alloc] init];
    BaseNavigationController *navDiscovery = [self initlizerNavigationControllerWithRootViewController:discovery];
    navDiscovery.navigationBar.barTintColor=YiBlue;
    navDiscovery.navigationBar.tintColor=[UIColor whiteColor];
    navDiscovery.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    MoreViewController *more=[[MoreViewController alloc] init];
    BaseNavigationController *navMore = [self initlizerNavigationControllerWithRootViewController:more];
    navMore.navigationBar.barTintColor=YiBlue;
    navMore.navigationBar.tintColor=[UIColor whiteColor];
    navMore.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    UITabBarController *tab=[[UITabBarController alloc] init];
    tab.viewControllers=@[navLanguageRank,navRepositories,navDiscovery,navMore];
    UITabBar *tabBar = tab.tabBar;
    tab.tabBar.backgroundColor=[UIColor whiteColor];
    tab.tabBar.tintColor=YiBlue;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    tabBarItem1.title=@"Users";
    tabBarItem1.image=[UIImage imageNamed:@"github60"];
    
    tabBarItem2.title=@"Repositories";
    tabBarItem2.image=[UIImage imageNamed:@"github160"];
    
    tabBarItem3.title=@"Discovery";
    tabBarItem3.image=[UIImage imageNamed:@"github60"];
    
    tabBarItem4.title=@"More";
    tabBarItem4.image=[UIImage imageNamed:@"more"];
    
    self.window.rootViewController=tab;
}

- (BaseNavigationController *)initlizerNavigationControllerWithRootViewController:(UIViewController *)rootViewController
{
    return [[BaseNavigationController alloc] initWithRootViewController:rootViewController];
}
@end
