//
//  FFField.h
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFFormatter;

@protocol FFFieldProtocol <NSObject>

@optional
- (void)resignResponder;
- (void)becomeResponder;

@required
- (BOOL)areFieldFilled;
- (id)valueField;
- (void)setValueField:(id)value;

@end

@interface FFField : UITableViewCell <FFFieldProtocol>

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger position;
@property (assign, nonatomic) BOOL required;
@property (strong, nonatomic) FFFormatter * formatter;
@property (assign, nonatomic) CGFloat horizontalInset;

@end
