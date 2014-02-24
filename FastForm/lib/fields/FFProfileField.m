//
//  FFProfileField.m
//  Weelo
//
//  Created by Paulo Pinheiro on 10/11/13.
//  Copyright (c) 2013 sergio vieira. All rights reserved.
//

#import "FFProfileField.h"

#import "DownloadOperation.h"

#import "ProfileCoreDataAdapter.h"

#import "FXManager.h"

@interface FFProfileField () <DownloadProtocol>

@property (strong, nonatomic) NSCache * profileDownloadRequests;

@end

@implementation FFProfileField

- (NSCache *)profileDownloadRequests
{
    if (!_profileDownloadRequests)
    {
        _profileDownloadRequests = [[NSCache alloc] init];
    }
    
    return _profileDownloadRequests;
}

- (BOOL)areFieldFilled
{
    return YES;
}

- (void)loadUserInfoWithJID:(XMPPJID *)jid
{
    NSAssert(jid, [Messages nilObject]);
    
    [[WCCoreXMPP instance].profileStorage profileWithJIDStr:[jid bare] withStream:[WCCoreXMPP instance].xmppStream completion:^(XMPPProfileCoreDataStorageObject * object) {
        if (object)
        {
            ProfileCoreDataAdapter * adapter = [[ProfileCoreDataAdapter alloc] initWithObject:object];
            
            self.nameLabel.text = [adapter name];
            self.statusLabel.text = [adapter quotedDescription];
        }
    }];
    
    /** getting profile photo and background **/
    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    
    // getting photo
    NSURL * url = [WCCoreApp urlFromJID:jid withFilename:kProfilePhoto];
    UIImage * image = [manager.imageCache imageFromDiskCacheForKey:url.absoluteString];
    
    if (!image)
    {
        DownloadOperation * downloadOperation = [self.profileDownloadRequests objectForKey:url.absoluteString];
        
        if (!downloadOperation)
        {
            downloadOperation = [[DownloadOperation alloc] initWithUrl:url withSize:CGSizeMake(156.f, 156.f)];
            downloadOperation.delegate = self;
            [self.profileDownloadRequests setObject:downloadOperation forKey:url.absoluteString];
            [downloadOperation start];
        }
    }
    else
    {
        [self.photoImageView setImage:image];
    }
    
    // getting background
    url = [WCCoreApp urlFromJID:jid withFilename:kProfileBackground];
    NSString * key = [NSString stringWithFormat:@"%@-half-blur", url.absoluteString];
    
    image = [manager.imageCache imageFromDiskCacheForKey:key];
    
    if (!image)
    {
        DownloadOperation * downloadOperation = [self.profileDownloadRequests objectForKey:url.absoluteString];
        
        if (!downloadOperation)
        {
            downloadOperation = [[DownloadOperation alloc] initWithUrl:url withSize:kProfileBackgroundRect.size];
            downloadOperation.delegate = self;
            [self.profileDownloadRequests setObject:downloadOperation forKey:url.absoluteString];
            [downloadOperation start];
        }
    }
    else
    {
        [self.backgroundImageView setImage:image];
    }
}

- (void)didDownload:(NSError *)error urlStr:(NSString *)theURL withImage:(UIImage *)theImage
{
    if (!error)
    {
        if ([self.profileDownloadRequests objectForKey:theURL])
        {
            NSRange range = [theURL rangeOfString:kProfilePhoto];
            
            if (range.location != NSNotFound)
            {
                [self.photoImageView setImage:theImage];
            }
            else
            {
                [FXManager blur:theImage withBlock:^(UIImage * blurImage) {
                    if (blurImage)
                    {
                        SDWebImageManager * manager = [SDWebImageManager sharedManager];
                        NSString * key = [NSString stringWithFormat:@"%@-half-blur", theURL];
                        
                        [manager.imageCache storeImage:blurImage forKey:key];
                        
                        [self.backgroundImageView setImage:blurImage];
                    }
                }];
//                [WCCoreApp imageWithBlur:theImage cropRect:kProfileBackgroundRect blurRect:kProfileBackgroundBlurRect withBlock:^(UIImage * blurImage) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        SDWebImageManager * manager = [SDWebImageManager sharedManager];
//                        NSString * key = [NSString stringWithFormat:@"%@-half-blur", theURL];
//                        
//                        [manager.imageCache storeImage:blurImage forKey:key];
//                        [self.backgroundImageView setImage:blurImage];
//                    });
//                }];
            }
            
            [self.profileDownloadRequests removeObjectForKey:theURL];
        }
    }
}

@end
