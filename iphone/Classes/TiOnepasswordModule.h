/**
 * Ti.OnePassword
 *
 * Created by Hans Knoechel
 * Copyright (c) 2016 Hans Knoechel. All rights reserved.
 */

#import "TiModule.h"

@interface TiOnepasswordModule : TiModule

/**
 * Determines if the 1Password Extension is available. Allows you to only show the 1Password login button to those
 * that can use it. Of course, you could leave the button enabled and educate users about the virtues of strong, unique
 * passwords instead :)
 *
 * @return Returns "true" if any app that supports the generic `org-appextension-feature-password-management` feature is installed on the device.
 * @since 1.0.0
 **/
-(id)isAppExtensionAvailable:(id)unused;

/*!
 * Called from your login page, this method will find all available logins for the given URLString.
 *
 * @param args The arguments object to be passed to the method. It contains the "url" and "callback" key.
 * @since 1.0.0
 */
-(void)findLoginForURLString:(id)args;

@end
