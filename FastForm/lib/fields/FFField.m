//
//  FFField.m
//  FastForm
//
//  Created by Paulo Pinheiro on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFField.h"

@implementation FFField

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _required = YES;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _required = YES;
}

- (BOOL)areFieldFilled
{
    return YES;
}

@end
