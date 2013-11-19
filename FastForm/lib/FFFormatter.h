//
//  FFFormatter.h
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFFormaterProtocol <NSObject>

@required
@property (strong, nonatomic) id raw;
- (NSString *)formattedValue;

@end

@interface FFFormatter : NSObject <FFFormaterProtocol>

@end
