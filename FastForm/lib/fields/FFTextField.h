//
//  FFTextField.h
//  Weelo
//
//  Created by Sérgio Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFField.h"

@interface FFTextField : FFField

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;

@end
