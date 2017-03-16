//
//  ViewController.m
//  LisztGuidePageExample
//
//  Created by 软擎信息科技 on 2016/12/14.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import "ViewController.h"
#import "LisztGuidePage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonAction:(UIButton *)sender {
    [LisztGuidePage addPages:@[@"liszt_guidepage_img0.jpg",@"liszt_guidepage_img1.jpg",@"liszt_guidepage_img2.jpg"] isShowButton:sender.tag==9?NO:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
