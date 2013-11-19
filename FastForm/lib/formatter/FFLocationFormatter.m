//
//  FFLocationFormatter.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFLocationFormatter.h"

NSString *const kLocationFormatterLatitude = @"latitude";
NSString *const kLocationFormatterLongitude = @"longitude";
NSString *const kLocationFormatteAddress = @"address";


@implementation FFLocationFormatter
{
    NSDictionary * raw_;
}

/**
    @out NSArray
    @[
        @(-3.85858),
        @(-38.5874),
    ]
*/
- (id)raw
{
    NSAssert(raw_[kLocationFormatterLatitude], @"Invalid Object");
    NSAssert(raw_[kLocationFormatterLongitude], @"Invalid Object");
    
    return @[
        raw_[kLocationFormatterLatitude],
        raw_[kLocationFormatterLongitude]
    ];
}

/**
    @in NSDictionary 
    @{
        @"latitude": @(-3.85858),
        @"longitude": @(-38.5874),
        @"address" : @"Rua tal e tudim, fortaleza, CE"
    }
*/
- (void)setRaw:(id)raw
{
    NSAssert([raw isKindOfClass:[NSDictionary class]], @"invalid object.");
    NSAssert(raw[kLocationFormatterLatitude], @"Invalid Object");
    NSAssert(raw[kLocationFormatterLongitude], @"Invalid Object");
    
    raw_ = raw;
}

- (NSString *)formattedValue
{
    return raw_[kLocationFormatteAddress];
}

@end
