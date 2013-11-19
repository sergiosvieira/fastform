//
//  FFDateFormatter.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFDateFormatter.h"

@implementation FFDateFormatter
{
    NSDate * raw_;
}

- (id)raw
{
    return raw_;
}

- (void)setRaw:(id)raw
{
    if (raw)
    {
        NSAssert([raw isKindOfClass:[NSDate class]], @"invalid object");
    }
    
    raw_ = raw;
}

- (NSString *)formattedValue
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kEventDateFormat];
    
    return [formatter stringFromDate:raw_];
}

@end
