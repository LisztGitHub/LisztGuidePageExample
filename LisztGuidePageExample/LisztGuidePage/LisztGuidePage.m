//
//  LisztGuidePage.m
//  LisztGuidePageExample
//
//  Created by 软擎信息科技 on 2016/12/14.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import "LisztGuidePage.h"

@interface LisztGuidePage()<UIScrollViewDelegate>
/*启动页图片*/
@property (strong, nonatomic) NSArray *guidePages;
/*showButton*/
@property (assign, nonatomic) BOOL showButton;

/*滚动视图*/
@property (strong, nonatomic) UIScrollView *guideScrollView;
/*page*/
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation LisztGuidePage

+ (instancetype)addPages:(NSArray<NSString *> *)pages isShowButton:(BOOL)showButton{
    return [[LisztGuidePage alloc]initWithPages:pages isShowButton:showButton];
}

- (instancetype)initWithPages:(NSArray<NSString *> *)pages isShowButton:(BOOL)showButton{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if(self){
        self.guidePages = pages;
        self.showButton = showButton;
        [self showGuidePage];
    }
    return self;
}

- (void)showGuidePage{
    [self addSubview:self.guideScrollView];
    [self addSubview:self.pageControl];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - UIControlEvent Action
- (void)pageControlValueChange:(UIPageControl *)pageControl{
    [self.guideScrollView setContentOffset:CGPointMake(pageControl.currentPage * CGRectGetWidth(self.frame), 0) animated:YES];
}
- (void)cancelButtonAction{
    [UIView animateWithDuration:0.3 animations:^{
        /*
         CGRect tempFrame  = self.frame;
         tempFrame.origin.y = -CGRectGetHeight(self.frame);
         self.frame = tempFrame;
         */
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    self.pageControl.currentPage = page;
}

#pragma mark - 懒加载
- (UIScrollView *)guideScrollView{
    if(!_guideScrollView){
        _guideScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _guideScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * (self.guidePages.count), CGRectGetHeight(self.bounds));
        _guideScrollView.pagingEnabled = YES;
        _guideScrollView.delegate = self;
        _guideScrollView.showsVerticalScrollIndicator = NO;
        _guideScrollView.showsHorizontalScrollIndicator = NO;
        _guideScrollView.bounces = NO;
        _guideScrollView.backgroundColor = [UIColor whiteColor];
        
        /*1.添加itemViews*/
        [self.guidePages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(idx * CGRectGetWidth(_guideScrollView.bounds), 0, CGRectGetWidth(_guideScrollView.bounds), CGRectGetHeight(_guideScrollView.bounds))];
            itemImageView.image = [UIImage imageNamed:obj];
            itemImageView.userInteractionEnabled = YES;
            [_guideScrollView addSubview:itemImageView];
            if(idx == self.guidePages.count-1){
                if(self.showButton){
                    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [cancelButton setTitle:@"开启领途" forState:UIControlStateNormal];
                    cancelButton.frame = CGRectMake((CGRectGetWidth(self.frame) - (self.frame.size.width - 60))/2, CGRectGetHeight(self.frame)-120, self.frame.size.width - 60, 44);
                    cancelButton.backgroundColor = [UIColor colorWithRed:30/255.f green:74/255.f blue:119/255.f alpha:0.6];
                    cancelButton.layer.cornerRadius = 4;
                    cancelButton.clipsToBounds = YES;
                    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
                    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
                    [itemImageView addSubview:cancelButton];
                }
            }
        }];
    }
    return _guideScrollView;
}
- (UIPageControl *)pageControl{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - (self.guidePages.count * 15))/2, CGRectGetHeight(self.frame)- 50, self.guidePages.count * 15, 30)];
        _pageControl.numberOfPages = self.guidePages.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        [_pageControl addTarget:self action:@selector(pageControlValueChange:) forControlEvents:UIControlEventValueChanged];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

@end
