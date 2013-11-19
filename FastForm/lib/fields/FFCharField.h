//
//  FFCharField.h
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFField.h"

@interface FFCharField : FFField

@property (strong, nonatomic) IBOutlet UIImageView * iconImageView;
@property (strong, nonatomic) IBOutlet UITextField * textField;

- (void)emailField:(BOOL)flag;

@end
