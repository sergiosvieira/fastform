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
    
    [self.photoButton addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)areFieldFilled
{
    return [self.photoButton backgroundImageForState:UIControlStateNormal] != nil &&
        [[self.firstNameTextField.text trim] length] > 0 && [[self.lastNameTextField.text trim] length] > 0;
}

@end
