//
//  FFSelectField.m
//  Weelo
//
//  Created by Paulo Pinheiro on 10/31/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFSelectField.h"

#import "FFFormatter.h"


@interface FFSelectField () <UIPickerViewDelegate>

@property (strong, nonatomic) UIButton * done;
@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) UIPickerView * picker;
@property (strong, nonatomic) UIView * view;

@end

@implementation FFSelectField
{
    NSString * selectedValue_;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /** customizing **/
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.f, 266.f)];
    
    /** adding components **/
    [self.view addSubview:self.done];
    [self.view addSubview:self.label];
    [self.view addSubview:self.picker];
}

- (void)becomeResponder
{
    self.tempTextField.inputView = self.view;
    [self.tempTextField becomeFirstResponder];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedValue_ = self.dataSource[row];
    self.formatter.selectedIndex = row;
    self.formatter.raw = self.dataSource[row];
    self.titleLabel.hidden = YES;
    self.valueLabel.hidden = NO;    
    self.valueField = self.formatter.formattedValue;
}
 
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSAssert(self.dataSource != nil, [Messages nilObject]);
    
    if (!selectedValue_)
    {
        selectedValue_ = self.dataSource[0];
    }
    
    return [self.dataSource count];
}
 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}
 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.widthForComponent > 0 ? self.widthForComponent : 320.f;
}

#pragma mark - Actions
- (void)didTouchDone:(UIButton *)sender
{
    self.formatter.raw = selectedValue_;
    self.valueField = self.formatter.formattedValue;
    self.titleLabel.hidden = YES;
    self.valueLabel.hidden = NO;
    [self resignResponder];
}

#pragma mark - Lazy Instantiating
- (UIPickerView *)picker
{
    if (!_picker)
    {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 40.f, 320.f, 226.f)];
        _picker.delegate = self;
        _picker.showsSelectionIndicator = YES;
    }
    
    return _picker;
}

- (UIButton *)done
{
    if (!_done)
    {
        _done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_done addTarget:self action:@selector(didTouchDone:) forControlEvents:UIControlEventTouchDown];
        _done.titleLabel.font = [UIFont fontWithName:@"GillSans-Light" size:17.0];
        [_done setTitle:[Messages done] forState:UIControlStateNormal];
        [_done setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _done.frame = CGRectMake(248.f, 7.f, 65.0, 35.0);
    }
    
    return _done;
}

- (UILabel *)label
{
    if (!_label)
    {
        CGRect frame = CGRectMake(15.f, 5.f, 320.f, 39.f);
        
        _label = [[UILabel alloc] initWithFrame:frame];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont fontWithName:@"GillSans-Light" size:17.f];
        _label.textColor = [UIColor darkGrayColor];
        _label.text = [Messages chooseOne];
    }
    
    return _label;
}

@end
