//
//  FFFormatter.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFFormatter.h"

@implementation FFFormatter
{
    NSString * raw_;
    NSInteger selectedIndex_;
}

- (id)raw
{
    return raw_;
}

- (void)setRaw:(id)raw
{
    raw_ = raw;
}

- (NSString *)formattedValue
{
    return raw_;
}

- (void)setSelectedIndex:(NSInteger)index
{
    selectedIndex_ = index;
}

- (NSInteger)selectedIndex
{
    return selectedIndex_;
}

@end
