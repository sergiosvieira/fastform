//
//  FFBigPhotoField.h
//  Weelo
//
//  Created by Sérgio Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFField.h"

@interface FFBigPhotoField : FFField

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) UIViewController * controller;

- (IBAction)changePhoto:(UIButton *)sender;

@end
