//
//  ViewController.h
//  demo2
//
//  Created by 刘勇 on 16/7/10.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import <UIKit/UIKit.h>

#define Boundary @"1a2b3c"
//一般换行
#define Wrap1 @"\r\n"
//key-value换行
#define Wrap2 @"\r\n\r\n"
//开始分割
#define StartBoundary [NSString stringWithFormat:@"--%@%@",Boundary,Wrap1]
//文件分割完成
#define EndBody [NSString stringWithFormat:@"--%@--",Boundary]

@interface ViewController : UIViewController


@end
