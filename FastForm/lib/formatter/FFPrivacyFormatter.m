//
//  FFPrivacyFormatter.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFPrivacyFormatter.h"

NSString * const kPrivacyFormatterPrivate = @"private";
NSString * const kPrivacyFormatterGallery = @"gallery";


@implementation FFPrivacyFormatter
{
    NSDictionary * raw_;
}

- (id)raw
{
    return raw_;
}

/**
    @in NSDictionary
    @{
        @"private": @(YES),
        @"gallery": @(NO),
    }
*/
- (void)setRaw:(id)raw
{
    NSAssert([raw isKindOfClass:[NSDictionary class]], @"Invalid object.");
    
    raw_ = raw;
}

- (NSString *)formattedValue
{
    BOOL privacy = [raw_[kPrivacyFormatterPrivate] boolValue];
    BOOL gallery = [raw_[kPrivacyFormatterGallery] boolValue];
    
    return [NSString stringWithFormat:@"%@:%@ - %@:%@",
        kPrivacyFormatterPrivate, privacy ? [Messages on] : [Messages off],
        kPrivacyFormatterGallery, gallery ? [Messages on] : [Messages off]
    ];
}

@end
