//
//  FFPhotoField.m
//  FastForm
//
//  Created by Paulo Pinheiro on 10/8/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFPhotoField.h"

@implementation FFPhotoField

- (BOOL)areFieldFilled
{
    return self.photo.image != nil;
}

@end
