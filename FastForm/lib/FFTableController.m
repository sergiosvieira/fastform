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


@interface FFTableController ()

@property (strong, nonatomic) NSMutableArray * model;

@end

@implementation FFTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    unsigned count;
    
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    
    _model = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char *propType = getPropertyType(property);
        
        UINib * nib = [UINib nibWithNibName:[NSString stringWithUTF8String:propType] bundle:[NSBundle mainBundle]];

        _model[i] = [nib instantiateWithOwner:self options:nil][0];
    }
    
}

static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    
    return "@";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FFField * cell = self.model[indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

@end
