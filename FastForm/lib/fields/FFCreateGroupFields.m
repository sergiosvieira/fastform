//
//  FFCreateGroupFields.m
//  Weelo
//
//  Created by Paulo Pinheiro on 3/10/14.
//  Copyright (c) 2014 sergio vieira. All rights reserved.
//

#import "FFCreateGroupFields.h"

#import "WCAlbumActionSheet.h"
#import "UzysImageCropperViewController.h"
#import "CameraCommand.h"
#import "AlbumCommand.h"
#import "DeleteCommand.h"


@interface FFCreateGroupFields () <UITextViewDelegate, UINavigationControllerDelegate, RDActionSheetDelegate,
    UzysImageCropperDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController  * imagePicker;
@property (strong, nonatomic) UzysImageCropperViewController * imgCropperViewController;
@property (assign, nonatomic) BOOL changedPhoto;

@end

@implementation FFCreateGroupFields
{
    CGRect previousRect;
    NSInteger numberOfLines_;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    previousRect = CGRectZero;
    self.descriptionTextView.contentInset = UIEdgeInsetsMake(-6,-4,0,0);
    self.descriptionTextView.delegate = self;
    
    UIColor * color = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.0];
    
    [self.photoButton.layer setBorderColor:[color CGColor]];
    [self.photoButton.layer setBorderWidth:1.f];
    [self.photoButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addPhoto
{
    [self.controller.view endEditing:YES];
    [WCAlbumActionSheet presentsInController:self.controller withDelegate:self];    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.placeHolderLabel.hidden = self.descriptionTextView.text.length > 0;
}

 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{

    NSMutableString * string = [NSMutableString stringWithString:textView.text];
    
    [string appendString:text];

    NSString * aux = textView.text;
    textView.text = string;
    
    CGSize size = [textView sizeThatFits:CGSizeMake(self.descriptionTextView.frame.size.width, 51)];
    NSLog(@"%@", NSStringFromCGSize(size));
    
    textView.text = aux;
    
    return size.height < 52;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize cropSize = CGSizeMake(160.f, 160.f);
    
    _imgCropperViewController = [[UzysImageCropperViewController alloc] initWithImage:image andframeSize:picker.view.frame.size
        andcropSize:cropSize];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _imgCropperViewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _imgCropperViewController.imagePicker = picker;
    _imgCropperViewController.info = info;
    _imgCropperViewController.delegate = self;
    _imgCropperViewController.navigationController.delegate = self;
    [picker presentViewController:_imgCropperViewController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UzysImageCropperDelegate
- (void)imageCropper:(UzysImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image
{
    self.changedPhoto = YES;
    self.selectedImage = image;
    [self.photoButton setBackgroundImage:image forState:UIControlStateNormal];
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(UzysImageCropperViewController *)cropper
{
    [cropper.imagePicker dismissViewControllerAnimated:YES completion:nil];
    self.selectedImage = nil;
    self.changedPhoto = NO;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{    
    WCCommand * command = nil;
    NSObject * object = nil;
    
    switch (buttonIndex)
    {
        case kWASActionCamera:
            command = [[CameraCommand alloc] init];
            object = self.controller;
        break;

        case kWASActionAlbum:
            command = [[AlbumCommand alloc] init];
            object = self.controller;
        break;

        case kWASActionDelete:
            command = [[DeleteCommand alloc] init];
            object = @[
                self.photoButton,
                [UIImage imageNamed:@"default-background-profile.png"]
            ];
            self.changedPhoto = NO;
        break;
    }
    
    command.delegate = self;
    [command performCommandwithObject:object];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController.navigationItem setTitle:@""];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - Lazy Instantiating
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker)
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            _imagePicker.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    return _imagePicker;
}

@end
