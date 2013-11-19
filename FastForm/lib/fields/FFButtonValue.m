//
//  FFButtonValue.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFButtonValue.h"

#import "NSString+Trim.h"


@implementation FFButtonValue

- (BOOL)areFieldFilled
{
    return [[self.valueLabel.text trim] length] > 0;
}

- (id)valueField
{
    return self.valueLabel.text;
}

- (void)setValueField:(id)value
{
    self.valueLabel.text = value;
}

- (void)becomeResponder
{
    [self.tempTextField becomeFirstResponder];
}

- (void)resignResponder
{
    [self.tempTextField resignFirstResponder];
}

#pragma mark - Lazy Instantiating
- (UITextField *)tempTextField
{
    if (!_tempTextField)
    {
        _tempTextField = [[UITextField alloc] init];
        _tempTextField.hidden = YES;
        [self addSubview:_tempTextField];
    }
    
    return _tempTextField;
}


@end
