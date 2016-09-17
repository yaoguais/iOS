//
// Created by Yao Guai on 16/7/23.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNWidgetUtil.h"
#import "ViewController.h"


@implementation MNWidgetUtil

+ (void)alertWithController:(UIViewController *)controller title:(NSString *)title mssage:(NSString *)message {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
    [alertVc addAction:action];
    [controller presentViewController:alertVc animated:YES completion:nil];
}

@end