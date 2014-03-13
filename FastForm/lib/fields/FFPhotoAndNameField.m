//
//  FFPhotoAndNameField.m
//  Weelo
//
//  Created by Paulo Pinheiro on 11/7/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFPhotoAndNameField.h"

#import "NSString+Trim.h"


@implementation FFPhotoAndNameField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIColor * color = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.0];
    
    [self.photoButton.layer setBorderColor:[color CGColor]];
    [self.photoButton.layer setBorderWidth:1.f];
    [self.photoButton addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)areFieldFilled
{
    return [self.photoButton backgroundImageForState:UIControlStateNormal] != nil &&
        [[self.firstNameTextField.text trim] length] > 0 && [[self.lastNameTextField.text trim] length] > 0;
}

@end
