//
//  FFCreateGroupFields.h
//  Weelo
//
//  Created by Paulo Pinheiro on 3/10/14.
//  Copyright (c) 2014 sergio vieira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFField.h"

@interface FFCreateGroupFields : FFField

@property (strong, nonatomic) IBOutlet UITextView * descriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel * placeHolderLabel;
@property (strong, nonatomic) IBOutlet UITextField * groupNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;

@property (weak, nonatomic) UIViewController * controller;
@property (strong, nonatomic) UIImage * selectedImage;

@end
