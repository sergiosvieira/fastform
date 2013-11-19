//
//  FFShowField.h
//  Weelo
//
//  Created by Paulo Pinheiro on 10/11/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFField.h"

@interface FFShowField : FFField

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
