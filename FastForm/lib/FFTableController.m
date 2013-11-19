//
//  FFTableController.m
//  FastForm
//
//  Created by Paulo Pinheiro on 9/25/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFTableController.h"

#import <objc/runtime.h>
#import "FFField.h"
#import "FFCharField.h"
#import "FFFormatter.h"


@interface FFTableController ()

@property (strong, nonatomic) NSMutableArray * model;

@end

@implementation FFTableController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self loadModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)loadModel
{
    unsigned int count;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
     _model = [[NSMutableArray alloc] init];
    _model[0] = [[NSMutableArray alloc] init];
    
    for(unsigned int i = 0; i < count; ++i)
    {
        Ivar variable = ivars[i];
        NSString * varName = [NSString stringWithUTF8String:ivar_getName(variable)];
        
        varName = [varName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        
        FFField * object = [self valueForKey:varName];
        
        if ([object isKindOfClass:[FFField class]])
        {
            if (object.section > [_model count] - 1)
            {
                _model[object.section] = [[NSMutableArray alloc] init];
            }
            
            NSMutableArray * rowArray = _model[object.section];
            
            [rowArray addObject:varName];
        }
    }
    
    free(ivars);
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.model count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFField * cell = [self valueForKey:self.model[indexPath.section][indexPath.row]];

    /** set value with formatter **/
    cell.valueField = cell.formatter.formattedValue;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFField * cell = [self valueForKey:self.model[indexPath.section][indexPath.row]];
    
    return cell.frame.size.height;
}

#pragma mark - FFTableControllerProtocol
- (NSString *)titleForSection:(NSInteger)section
{
    return @"";
}

#pragma mark - Public Methods
- (FFField *)requiredFieldsAreFilled
{
    FFField * result = nil;
    
    for (NSMutableArray * row in self.model)
    {
        for (NSString * fieldName in row)
        {
            FFField * field = [self valueForKey:fieldName];
            
            if (field.required && ![field areFieldFilled])
            {
                return field;
            }
        }
    }
    
    return result;
}

- (id)instantiatingCellWithName:(NSString *)cellName
{
    UINib * nib = [UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]];
        
    return [nib instantiateWithOwner:self options:nil][0];
}

- (FFField *)fieldWithIndexPath:(NSIndexPath *)indexPath
{
    return [self valueForKey:self.model[indexPath.section][indexPath.row]];
}

@end
