//
//  UIImage+Utils.h
//  IDVerifyFramework
//
//  Created by Jura on 05/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)pp_imageNamed:(NSString *)name type:(NSString *)type inBundle:(NSBundle *)bundle;

+ (UIImage *)pp_imageInResourcesBundleNamed:(NSString *)imageName;

@end
