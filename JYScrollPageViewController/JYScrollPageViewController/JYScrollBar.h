//
//  JYScrollBar.h
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JYScrollBarNoParametersCompletionBlock)();
typedef void (^JYScrollBarDidSelectedCompletionBlock)(NSInteger, NSInteger);

@interface JYScrollBar : UIView

/**
 *  scrollBar上每个section的标题数组.
 */
@property (nonatomic, strong) NSArray <NSString *>*sectionTitles;

/**
 *  设置scrollBar的颜色.
 */
@property (nonatomic, strong) UIColor *scrollBarColor;

/**
 *  设置scrollBar上的标题颜色.
 */
@property (nonatomic, strong) UIColor *scrollBarTextColor;

/**
 *  设置scrollBar上的标题文字大小.默认为17.0.
 */
@property (nonatomic, assign) CGFloat scrollBarTitleFontSize;

/**
 *  设置scrollBar默认在一屏上显示多少个titles.默认为5个.
 */
@property (nonatomic, assign) NSInteger numberOfTitlesForOneScreen;

/**
 *  用于设置scrollBar对应的index的标题
 *
 *  @param index             控制器对应标题的index.
 *  @param completionHandler 设置选中的标题后的callback.
 */
- (void)setSelectedIndex: (NSInteger)index completionHandler: (JYScrollBarNoParametersCompletionBlock) completionHandler;

/**
 *  用于获取当前scrollBar选中的index.
 *
 *  @param completionHandler 回调block,获得当前选中的index.
 */
- (void)didSelectedWithComletionHandler: (JYScrollBarDidSelectedCompletionBlock)completionHandler;

@end
