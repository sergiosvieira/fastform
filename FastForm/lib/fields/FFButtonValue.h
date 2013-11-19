//
//  FFButtonValue.h
//  Weelo
//
//  Created by Sérgi Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFField.h"

@interface FFButtonValue : FFField

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) UITextField * tempTextField;

@end
