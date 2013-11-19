//
//  FFTextField.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFTextField.h"

#import "NSString+Trim.h"

@interface FFTextField () <UITextViewDelegate>

@end


@implementation FFTextField

- (BOOL)areFieldFilled
{
    return [[self.textView.text trim] length] > 0;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if ([[textView.text trim]length] > 0)
    {
        self.placeholderLabel.hidden = YES;
    }
    else
    {
        self.placeholderLabel.hidden = NO;
    }
}

- (void)awakeFromNib
{
    self.placeholderLabel.hidden = NO;
    self.textView.delegate = self;
}

- (void)becomeResponder
{
    [self.textView becomeFirstResponder];
}

@end
