//
//  JYScrollPageControllerDelegate.h
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/26.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  在pageVC中的控制器必须遵守此协议，并且实现@required中的方法.
 */
@protocol JYScrollPageViewConrtollerDelegate <NSObject>

@required
- (NSString *)titleForPageViewController;


@end

@interface JYScrollPageControllerDelegate : NSObject

@end