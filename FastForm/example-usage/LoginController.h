//
//  LoginController.h
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFTableController.h"

@class FFCharField, FFPhotoField;

@interface LoginController : FFTableController

@property (strong, nonatomic) FFPhotoField * photoField;
@property (strong, nonatomic) FFCharField * firstName;
@property (strong, nonatomic) FFCharField * lastName;
@property (strong, nonatomic) FFCharField * email;
@property (strong, nonatomic) FFCharField * password;

@end
