//
//  FFCharField.m
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFCharField.h"

@implementation FFCharField

- (BOOL)areFieldFilled
{
    return [[self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0;
}

@end
