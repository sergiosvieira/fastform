//
//  FFDateField.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFDateField.h"

#import "WCDateTimePicker.h"
#import "FFFormatter.h"

@interface FFDateField () <WCDateTimePickerDelegate>

@property (strong, nonatomic) WCDateTimePicker * datePicker;

@end

@implementation FFDateField
{
    UIDatePickerMode mode_;
}

#pragma mark - Lazy Instantiating
- (WCDateTimePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[WCDateTimePicker alloc] initWithDateMode:mode_];
        _datePicker.textDescription = [Messages selectADate];
        _datePicker.delegate = self;
    }
    
    return _datePicker;
}

- (void)didDateTimeChange:(UIDatePicker *)datePicker
{
    self.formatter.raw = datePicker.date;
    self.valueField = self.formatter.formattedValue;
    self.titleLabel.hidden = YES;
    self.valueLabel.hidden = NO;
}

- (void)didTouchSend
{
    self.formatter.raw = [self.datePicker getDate];
    self.valueField = self.formatter.formattedValue;
    self.titleLabel.hidden = YES;
    self.valueLabel.hidden = NO;    
    [self resignResponder];
}

- (void)becomeResponder
{
    self.tempTextField.inputView = self.datePicker.view;
    [self.tempTextField becomeFirstResponder];
}

- (void)setDatePickerMode:(UIDatePickerMode)mode
{
    mode_ = mode;
    
    if (mode == UIDatePickerModeDate)
    {
        self.datePicker.textDescription = [Messages selectADate];
    }
    else if (mode == UIDatePickerModeTime)
    {
        self.datePicker.textDescription = [Messages selectATime];
    }
    else
    {
        self.datePicker.textDescription = [Messages chooseOne];
    }
}

- (void)setDate:(NSDate *)date
{
    [self.datePicker setDate:date];
}

@end
