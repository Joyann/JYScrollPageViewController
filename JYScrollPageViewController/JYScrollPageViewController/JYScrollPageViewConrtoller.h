//
//  JYScrollPageViewConrtoller.h
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYScrollPageControllerDelegate.h"

@class JYScrollPageViewConrtoller;
@class JYScrollPageControllerDelegate;

typedef NS_ENUM(NSInteger, JYScrollPageViewTransitionType) {
    /**
     *  从右向左切换控制器view.
     */
    JYScrollPageViewTransitionTypeRight2Left,
    /**
     *  从左向右切换控制器view.
     */
    JYScrollPageViewTransitionTypeLeft2Right,
    /**
     *  根据scrollBar的点击自动切换控制器view.如果下一次点击的标题在当前的右边，则从右向左切换；如果在当前的左边，则从左向右切换.
     */
    JYScrollPageViewTransitionTypeAutomatic
};

@interface JYScrollPageViewConrtoller : UIViewController

/**
 *  pageVC中的控制器,传入的数组中的控制器将被添加到pageVC中.
 */
@property (nonatomic, strong) NSArray <UIViewController <JYScrollPageViewConrtollerDelegate> *> *pageViewControllers;

/**
 *  设置scrollBar的大小和位置.
 */
@property (nonatomic, assign) CGRect scrollBarFrame;

/**
 *  切换控制器view的方向.默认为`JYScrollPageViewTransitionTypeAutomatic`切换.
 */
@property (nonatomic, assign) JYScrollPageViewTransitionType transitionType;

/**
 *  决定是否显示scrollBar.默认为YES.
 */
@property (nonatomic, assign) BOOL showScrollBar;

@end
