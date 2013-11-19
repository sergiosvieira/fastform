//
//  FFProfileField.h
//  Weelo
//
//  Created by Paulo Pinheiro on 10/11/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFField.h"

@interface FFProfileField : FFField

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

- (void)loadUserInfoWithJID:(XMPPJID *)jid;

@end
