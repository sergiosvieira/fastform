//
//  FFPhotoField.m
//  FastForm
//
//  Created by Sérgio Vieira on 10/8/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "FFPhotoField.h"

#import "UzysImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface FFPhotoField () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UzysImageCropperDelegate>

@property (strong, nonatomic) UIImagePickerController  * imagePicker;
@property (strong, nonatomic) UzysImageCropperViewController * imgCropperViewController;

@end

@implementation FFPhotoField

- (BOOL)areFieldFilled
{
    return [self.photoButton backgroundImageForState:UIControlStateNormal] != nil;
}

- (IBAction)choosePhoto:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        self.imagePicker.delegate = self;
        [self.controller presentViewController:self.imagePicker animated:YES completion:NULL];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:[Messages ok]
            otherButtonTitles:nil];

        [alert setTitle:[Messages error]];
        [alert setMessage:[Messages noAlbum]];
        [alert show];
        
        [self.imagePicker dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize cropSize = kContactsGridRectUpload.size;
    
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
    [self.imagePicker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UzysImageCropperDelegate
- (void)imageCropper:(UzysImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image
{
    [self.photoButton setBackgroundImage:image forState:UIControlStateNormal];
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(UzysImageCropperViewController *)cropper
{
    [cropper.imagePicker dismissViewControllerAnimated:YES completion:nil];
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
