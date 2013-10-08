//
//  FFTableController.h
//  FastForm
//
//  Created by Sérgio Vieira on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFField;

@protocol FFTableControllerProtocol <NSObject>

@required
- (NSString *)titleForSection:(NSInteger)section;
/**
    it checks if all required fiels are filled, if not,
    it return the first required fields which not filled
*/

@end

@interface FFTableController : UITableViewController <FFTableControllerProtocol>

- (FFField *)requiredFieldsAreFilled;
- (id)instantiatingCellWithName:(NSString *)cellName;

@end
