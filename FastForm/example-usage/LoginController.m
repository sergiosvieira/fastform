//
//  LoginController.m
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "LoginController.h"

#import "FFCharField.h"
#import "FFPhotoField.h"


@interface LoginController ()

@end


@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** adds right button **/
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
        target:self action:@selector(done:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}

- (FFPhotoField *)photoField
{
    if (!_photoField)
    {
        _photoField = [self instantiatingCellWithName:@"FFPhotoField"];
    }
    
    return _photoField;
}

- (FFCharField *)firstName
{
    if (!_firstName)
    {
        _firstName = [self instantiatingCellWithName:@"FFCharField"];
        _firstName.section = 0;
        _firstName.textField.placeholder = @"First Name";
    }
    
    return _firstName;
}

- (FFCharField *)lastName
{
    if (!_lastName)
    {
        _lastName = [self instantiatingCellWithName:@"FFCharField"];
        _lastName.section = 0;
        _lastName.textField.placeholder = @"Last Name";
    }
    
    return _lastName;
}

- (FFCharField *)email
{
    if (!_email)
    {
        _email = [self instantiatingCellWithName:@"FFCharField"];
        _email.section = 1;
        _email.textField.placeholder = @"Email";
    }
    
    return _email;
}

- (FFCharField *)password
{
    if (!_password)
    {
        _password = [self instantiatingCellWithName:@"FFCharField"];
        _password.section = 1;
        _password.textField.placeholder = @"Password";
        _password.textField.secureTextEntry = YES;
    }
    
    return _password;
}

- (NSString *)titleForSection:(NSInteger)section
{
    NSArray * sections = @[
        @"Personal Information",
        @"Account"
    ];
    
    NSAssert([sections count] > section, @"invalid section number");
    
    return sections[section];
}

- (void)done:(UIButton *)sender
{
    id field = [self requiredFieldsAreFilled];
    
    if ([field isKindOfClass:[FFCharField class]])
    {
        FFCharField * charField = field;
        [charField.textField becomeFirstResponder];
    }
    
    if (!field)
    {
        NSLog(@"OK");
    }
}

@end
