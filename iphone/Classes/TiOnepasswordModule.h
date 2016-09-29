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
 * that can use it. Of course, you could leave the button enabled and educate users about the virtues of strong, 
 * unique passwords instead :)
 *
 * @return Returns "true" if any app that supports the generic `org-appextension-feature-password-management` 
           feature is installed on the device.
 * @since 1.0.0
 **/
-(id)isAppExtensionAvailable:(id)unused;

/*!
 * Called from your login page, this method will find all available logins for the given URLString.
 *
 * @param args The arguments object to be passed to the method. It contains the "url", "callback" 
 *             and (optional) "source" key.
 * @since 1.0.0
 */
-(void)findLoginForURLString:(id)args;

/*!
 * Create a new login within 1Password and allow the user to generate a new password before saving. The provided
 * URLString should be unique to your app or service and be identical to what you pass into
 * the find login method.
 *
 * @param args The arguments object to be passed to the method. It contains the "url", "callback" 
 *             and keys as well as the optional keys "source" and "options".
 * @since 1.1.0
 */
-(void)storeLoginForURLString:(id)args;

/*!
 * Change the password for an existing login within 1Password. The provided URLString should be unique to your
 * app or service and be identical to what you pass into the find login method. The completion block is guaranteed
 * to be called on the main thread.
 *
 * @param args The arguments object to be passed to the method. It contains the "url", "callback"
 *             and keys as well as the optional keys "source" and "options".
 * @since 1.1.0
 */
-(void)changePasswordForLoginForURLString:(id)args;

@end
