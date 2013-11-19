//
//  FFSelectField.h
//  Weelo
//
//  Created by Paulo Pinheiro on 10/31/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFButtonValue.h"

@interface FFSelectField : FFButtonValue

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) NSArray * dataSource;
@property (assign, nonatomic) NSInteger widthForComponent;

@end
