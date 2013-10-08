//
//  FFField.h
//  FastForm
//
//  Created by Paulo Pinheiro on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFFieldProtocol <NSObject>

@required
- (BOOL)areFieldFilled;

@end

@interface FFField : UITableViewCell <FFFieldProtocol>

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger position;
@property (assign, nonatomic) BOOL required;

@end
