//
//  FFBigPhotoField.m
//  Weelo
//
//  Created by Sérgio Vieira on 10/14/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFBigPhotoField.h"

#import "UzysImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "WCAlbumActionSheet.h"
#import "WCCommand.h"
#import "CameraCommand.h"
#import "AlbumCommand.h"
#import "DeleteCommand.h"


@interface FFBigPhotoField () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UzysImageCropperDelegate, RDActionSheetDelegate>

@property (strong, nonatomic) UIImagePickerController  * imagePicker;
@property (strong, nonatomic) UzysImageCropperViewController * imgCropperViewController;
@property (assign, nonatomic) BOOL changedPhoto;

@end

@implementation FFBigPhotoField

- (BOOL)areFieldFilled
{
    return self.changedPhoto;
}

- (IBAction)changePhoto:(UIButton *)sender
{
    [self.controller.view endEditing:YES];
    [WCAlbumActionSheet presentsInController:self.controller withDelegate:self];
}

- (void)becomeResponder
{
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize cropSize = CGSizeMake(560.f, 246.f);
    
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
    self.selectedImage.image = image;
    [self.photoButton setBackgroundImage:image forState:UIControlStateNormal];
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(UzysImageCropperViewController *)cropper
{
    [cropper.imagePicker dismissViewControllerAnimated:YES completion:nil];
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
