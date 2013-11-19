//
//  FFPhotoField.h
//  FastForm
//
//  Created by Sérgio Vieira on 10/8/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFField.h"

@interface FFPhotoField : FFField

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) UIViewController * controller;

- (IBAction)choosePhoto:(id)sender;

@end
