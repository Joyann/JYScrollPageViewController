//
//  JYScrollPageViewConrtoller.m
//  JYScrollPageViewController
//
//  Created by joyann on 15/11/23.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYScrollPageViewConrtoller.h"
#import "JYScrollBar.h"

#define kScrollBarDefaultWidth self.view.bounds.size.width

static const CGFloat kScrollBarDefaultHeight  = 50.0;
static const CGFloat kScrollBarDefaultOriginX = 0;
static const CGFloat kScrollBarDefaultOriginY = 0;

@interface JYScrollPageViewConrtoller () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, weak) UIPageViewController *pageVC;
@property (nonatomic, weak) JYScrollBar *scrollBar;
@end

@implementation JYScrollPageViewConrtoller

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addPageViewController];
    
    [self addScrollBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self update];
}



#pragma mark - Add

- (void)addPageViewController
{
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    pageVC.dataSource = self;
    pageVC.delegate = self;
    
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    [pageVC didMoveToParentViewController:self];
    
    self.pageVC = pageVC;
}

#pragma mark - Setter Methods

- (void)setPageViewControllers:(NSArray<UIViewController<JYScrollPageViewConrtollerDelegate> *> *)pageViewControllers
{
    _pageViewControllers = pageViewControllers;
    
    [self update];
}

#pragma mark - Helper Methdos

- (void)update
{
    // 更新scrollBar的sectionTitles.
    [self updateScrollBarSectionTitles];
    
    // 默认地，应该将`pageViewControllers`中的第一个控制器的视图显示出来.
    [self showPageViewContollerWithIndex: 0];
}


- (void)showPageViewContollerWithIndex: (NSInteger)index
{
    if (!self.pageViewControllers) {
        return;
    }
    [self.pageVC setViewControllers:@[self.pageViewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)updateScrollBarSectionTitles
{
    // 在这个方法中要将pageViewControllers里面的每个vc取出来，因为每个vc实现了`JYScrollPageViewControllerDelegate`协议，所以我们可以通过相应的方法拿到每个vc要设置的title，放入数组中给scrollBar的sectionTitles赋值来更新.
    NSMutableArray *titles = [NSMutableArray array];
    if (self.pageViewControllers.count > 0) {
        [self.pageViewControllers enumerateObjectsUsingBlock:^(UIViewController <JYScrollPageViewConrtollerDelegate>  * _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *sectionTitle = [viewController titleForPageViewController];
            [titles addObject:sectionTitle];
        }];
    }
    
    // 给scollBar赋值来刷新scrollBar.
    self.scrollBar.sectionTitles = titles;
}

- (void)addScrollBar
{
    // 添加scrollBar.
    JYScrollBar *scrollBar = [[JYScrollBar alloc] initWithFrame:CGRectMake(kScrollBarDefaultOriginX, kScrollBarDefaultOriginY, kScrollBarDefaultWidth, kScrollBarDefaultHeight)];
    [self.view addSubview:scrollBar];
    self.scrollBar = scrollBar;
    
    // 当scrollBar发生点击标题事件的时候会回调这个block.相当于将值从scrollBar传到当前类中.
    [scrollBar didSelectedWithComletionHandler:^(NSInteger selecedIndex) {
        // 当发生点击标题事件的时候，设置这个标题对应的控制器
        [self.pageVC setViewControllers:@[self.pageViewControllers[selecedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }];
}

#pragma mark - UIPageViewControllerDataSouce

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController <JYScrollPageViewConrtollerDelegate> *)viewController
{
    NSInteger currentIndex = [self.pageViewControllers indexOfObject:viewController];
    // 当currentIndex等于0或者找不到的时候，则表示没有前一个vc，即直接返回
    if (currentIndex == 0 || currentIndex == NSNotFound) {
        return nil;
    }
    NSInteger preIndex = --currentIndex;
    // 返回前一个vc
    return self.pageViewControllers[preIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController <JYScrollPageViewConrtollerDelegate> *)viewController
{
    NSInteger currentIndex = [self.pageViewControllers indexOfObject:viewController];
    // 当currentIndex等于最后一个vc的下标或者没有找到，则表示没有下一个vc，即直接返回
    if (currentIndex == (self.pageViewControllers.count - 1) || currentIndex == NSNotFound) {
        return nil;
    }
    NSInteger nextIndex = ++currentIndex;
    // 返回后一个vc
    return self.pageViewControllers[nextIndex];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed) {
        return;
    }
    
    // 当手势拖动vc完毕并且动画结束，设置当前vc对应的scrollBar的标题
    // self.pageVC.viewControllers即为当前显示的vc的数组.这个数组中只有一个当前正在显示的vc.
    NSInteger currentIndex = [self.pageViewControllers indexOfObject:self.pageVC.viewControllers.firstObject];
    
    [self.scrollBar setSelectedIndex:currentIndex completionHandler:nil];
}

@end
