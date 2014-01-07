//
//  FFDateField.h
//  Weelo
//
//  Created by Sérgio Vieira on 10/15/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFButtonValue.h"

@interface FFDateField : FFButtonValue

- (void)setDatePickerMode:(UIDatePickerMode)mode;
- (void)setDate:(NSDate *)date;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@end
