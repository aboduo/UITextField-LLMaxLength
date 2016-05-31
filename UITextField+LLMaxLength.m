//
//  UITextField+LLMaxLength.m
//  LionLiving
//
//  Created by sheng on 5/31/16.
//  Copyright © 2016 com.youxiduo. All rights reserved.
//

#import "UITextField+LLMaxLength.h"
#import <objc/runtime.h>

static char kMaxLength;

@implementation UITextField (LLMaxLength)

@dynamic maxLength;

- (void)__checkTextLength:(UITextField *)textField
{
    NSString *destText = textField.text;
    NSUInteger maxLength = textField.maxLength;
    
    // 对中文的特殊处理，shouldChangeCharactersInRangeWithReplacementString 并不响应中文输入法的选择事件
    // 如拼音输入时，拼音字母处于选中状态，此时不判断是否超长
    UITextRange *selectedRange = [textField markedTextRange];
    if (!selectedRange || !selectedRange.start) {
        if (destText.length > maxLength) {
            textField.text = [destText substringToIndex:maxLength];
        }
    }
}

- (void)setMaxLength:(NSUInteger)maxLength
{
    objc_setAssociatedObject(self, &kMaxLength, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (maxLength)
    {
        [self removeTarget:self
                    action:@selector(__checkTextLength:)
          forControlEvents:UIControlEventEditingChanged];
        
        [self addTarget:self
                 action:@selector(__checkTextLength:)
       forControlEvents:UIControlEventEditingChanged];
    }
    else
    {
        [self removeTarget:self
                    action:@selector(__checkTextLength:)
          forControlEvents:UIControlEventEditingChanged];
    }
}

-(NSUInteger)maxLength
{
    NSNumber *number = objc_getAssociatedObject(self, &kMaxLength);
    return [number integerValue];
}

@end


