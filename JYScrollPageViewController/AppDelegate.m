//
//  AppDelegate.m
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "AppDelegate.h"
#import "JYScrollPageViewConrtoller.h"
#import "JYPageViewController1.h"
#import "JYPageViewController2.h"
#import "JYPageViewController3.h"
#import "JYPageViewController4.h"
#import "JYPageViewController5.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JYScrollPageViewConrtoller *pageVC = [[JYScrollPageViewConrtoller alloc] init];
    
    JYPageViewController1 *page1 = [[JYPageViewController1 alloc] init];
    page1.view.backgroundColor = [UIColor blueColor];
    
    JYPageViewController2 *page2 = [[JYPageViewController2 alloc] init];
    page2.view.backgroundColor = [UIColor greenColor];
    
    JYPageViewController3 *page3 = [[JYPageViewController3 alloc] init];
    page3.view.backgroundColor = [UIColor yellowColor];
    
    JYPageViewController4 *page4 = [[JYPageViewController4 alloc] init];
    page4.view.backgroundColor = [UIColor redColor];
    
    JYPageViewController5 *page5 = [[JYPageViewController5 alloc] init];
    page5.view.backgroundColor = [UIColor purpleColor];
    
    self.window.rootViewController = pageVC;
    [self.window makeKeyAndVisible];
    
    pageVC.showScrollBar = YES;

    pageVC.pageViewControllers = @[page1, page2, page3, page4, page5];
    return YES;
}

@end
