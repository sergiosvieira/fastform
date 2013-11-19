//
//  FFPhotoAndNameField.h
//  Weelo
//
//  Created by Paulo Pinheiro on 11/7/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFPhotoField.h"

@interface FFPhotoAndNameField : FFPhotoField

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;


@end
