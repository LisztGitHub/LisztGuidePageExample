//
//  LisztGuidePage.h
//  LisztGuidePageExample
//
//  Created by 软擎信息科技 on 2016/12/14.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LisztGuidePage : UIView
/*
 初始化引导页控件
 @param pages 本地图片名称
 @param showButton 是否显示确定按钮
 */
+ (instancetype)addPages:(NSArray <NSString *>*)pages isShowButton:(BOOL)showButton;
@end
