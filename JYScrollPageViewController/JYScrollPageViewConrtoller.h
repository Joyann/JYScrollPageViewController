//
//  JYScrollPageViewConrtoller.h
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYScrollPageViewConrtoller;

/**
 *  在pageVC中的控制器必须遵守此协议，并且实现@required中的方法.
 */
@protocol JYScrollPageViewConrtollerDelegate <NSObject>

@required
- (NSString *)titleForPageViewController;

@end

@interface JYScrollPageViewConrtoller : UIViewController

/**
 *  pageVC中的控制器,传入的数组中的控制器将被添加到pageVC中.
 */
@property (nonatomic, strong) NSArray <UIViewController <JYScrollPageViewConrtollerDelegate> *> *pageViewControllers;

/**
 *  设置scrollBar的大小和位置.
 */
@property (nonatomic, assign) CGRect scrollBarFrame;

@end
