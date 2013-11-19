//
//  FFField.m
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
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

- (id)valueField
{
    return nil;
}

- (void)setValueField:(id)value
{
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += self.horizontalInset;
    frame.size.width -= 2 * self.horizontalInset;
    [super setFrame:frame];
}

@end
