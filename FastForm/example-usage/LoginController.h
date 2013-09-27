//
//  LoginController.h
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFTableController.h"

#import "FFCharField.h"


@interface LoginController : FFTableController

@property (strong, nonatomic) FFCharField * name;
@property (strong, nonatomic) FFCharField * password;

@end
