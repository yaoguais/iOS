//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YGIsNotNull(obj) (obj && (![obj isEqual:[NSNull null]]) && (![obj isEqual:@"<null>"]) )
#define YGIsValidDictionary(dict) (YGIsNotNull(dict) && [dict isKindOfClass:[NSDictionary class]])
#define YGIsValidArray(array) (YGIsNotNull(array) && [array isKindOfClass:[NSArray class]])
#define YGIsValidString(str) (YGIsNotNull(str) && [str isKindOfClass:[NSString class]])
#define YGIsEmptyString(str) (!YGIsValidString(str) || [str length] == 0)
#define YGIsValidNumber(num) (YGIsNotNull(num) && [num isKindOfClass:[NSNumber class]])


#define YGScreenScale [UIScreen mainScreen].scale
#define YGLineWidth 1.0 / [UIScreen mainScreen].scale
#define YGScreenHeight [[UIScreen mainScreen] bounds].size.height
#define YGScreenWidth [[UIScreen mainScreen] bounds].size.width

#define YGiPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define YGiPhone4sAndAbove ([UIScreen mainScreen].bounds.size.height >480)
#define YGiPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define YGiPhone5AndLower ([UIScreen mainScreen].bounds.size.height <=568)
#define YGiPhone5AndAbove ([UIScreen mainScreen].bounds.size.height >=568)
#define YGiPhone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define YGiPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736)

#define YGViewWidth(obj) obj.frame.size.width
#define YGViewHeight(obj) obj.frame.size.height
#define YGWindowWidth [UIScreen mainScreen].bounds.size.width
#define YGWindowHeight [UIScreen mainScreen].bounds.size.height
#define YGShowBorder(obj) {obj.layer.borderColor = [UIColor redColor].CGColor;obj.layer.borderWidth = 1.0;}