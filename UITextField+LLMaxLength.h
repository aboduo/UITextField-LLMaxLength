//
//  UITextField+LLMaxLength.h
//  LionLiving
//
//  Created by sheng on 5/31/16.
//  Copyright © 2016 com.youxiduo. All rights reserved.
//

#import <UIKit/UIKit.h>

//参考：： https://github.com/edokeh/UITextField-MaxLength

IB_DESIGNABLE
@interface UITextField (LLMaxLength)

@property (assign, nonatomic) IBInspectable NSUInteger maxLength;

@end