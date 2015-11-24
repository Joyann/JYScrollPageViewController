//
//  JYScrollBar.m
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYScrollBar.h"

#define kNumberOfTitlesPerScreen        4
#define kScrollBarDefultTitleFontSize   20.0
#define kSectionTitleButtonMargin       20.0
#define kScrollBarCenterY               self.bounds.size.height * 0.5
#define kScrollBarDefaultColor          [UIColor colorWithRed:0.6 green:0.62 blue:0.68 alpha:1]
#define kScrollBarTextDefaultColor      [UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1]

@interface JYScrollBar ()

@property (nonatomic, strong) NSArray <UIButton *>* titleButtons;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger preSelectedIndex;

@property (nonatomic, copy) JYScrollBarDidSelectedCompletionBlock didSelectedBlock;

@end

@implementation JYScrollBar

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 修改scrollView的frame.
    self.scrollView.frame = self.bounds;

    // 添加labels
    NSMutableArray *buttons = [NSMutableArray array];
    self.titleButtons = buttons;
    
    // 根据`numberOfTitlesForOneScreen`计算label适合的宽度.
    CGFloat w = self.bounds.size.width / ((self.numberOfTitlesForOneScreen != 0) ? self.numberOfTitlesForOneScreen : kNumberOfTitlesPerScreen) ;

    CGFloat h = 30.0;
    
    [self.sectionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = kSectionTitleButtonMargin + (w + kSectionTitleButtonMargin) * idx;
        CGFloat y = kScrollBarCenterY - h * 0.5;
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleButton setTitleColor:(self.scrollBarTextColor ? self.scrollBarTextColor : kScrollBarTextDefaultColor) forState:UIControlStateNormal];
        [titleButton.titleLabel setFont:[UIFont systemFontOfSize:(self.scrollBarTitleFontSize != 0.0) ? self.scrollBarTitleFontSize : kScrollBarDefultTitleFontSize]];
        [titleButton setTitle:self.sectionTitles[idx] forState:UIControlStateNormal];

        [titleButton addTarget:self action:@selector(didSelectedTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:titleButton];
        
        [buttons addObject:titleButton];

    }];
    
    
    CGFloat maxX = CGRectGetMaxX(self.titleButtons.lastObject.frame);
    
    // 设置scrollView的滑动范围
    self.scrollView.contentSize = CGSizeMake(maxX, 0);
    
    // 设置第一个标题为选中
    self.selectedIndex = 0;

    self.preSelectedIndex = 0;
}


#pragma mark - Handle Tap

- (void)didSelectedTitle: (UIButton *)titleButton
{
    NSInteger index = [self.titleButtons indexOfObject:titleButton];
    self.selectedIndex = index;
    
    self.didSelectedBlock(self.selectedIndex);
}

#pragma mark - Common Init

- (void)commonInit
{
    // 添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 设置scrollBar背景颜色
    self.backgroundColor = kScrollBarDefaultColor;
}

#pragma mark - Setter Methdos

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles
{
    _sectionTitles = sectionTitles;
    
    [self layoutIfNeeded];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex || selectedIndex == 0) {
        _selectedIndex = selectedIndex;
        
        if (self.titleButtons.count) {
            
            UIButton *preButton = self.titleButtons[self.preSelectedIndex];
            [preButton setTitleColor:kScrollBarTextDefaultColor forState:UIControlStateNormal];
            
            UIButton *currentButton = self.titleButtons[selectedIndex];
            [currentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            self.preSelectedIndex = selectedIndex;
        }
    }

}

#pragma mark - Public Methods

- (void)didSelectedWithComletionHandler:(JYScrollBarDidSelectedCompletionBlock)completionHandler
{
    self.didSelectedBlock = completionHandler;
}

- (void)setSelectedIndex:(NSInteger)index completionHandler:(JYScrollBarNoParametersCompletionBlock)completionHandler
{
    self.selectedIndex = index;
    
    if (completionHandler) {
        completionHandler();
    }
}

@end
