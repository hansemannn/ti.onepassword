/**
 * Ti.OnePassword
 *
 * Created by Hans Knoechel
 * Copyright (c) 2016 Hans Knoechel. All rights reserved.
 */

#import "TiOnepasswordModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "OnePasswordExtension.h"

@implementation TiOnepasswordModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"3506d384-99f9-409f-a4f3-a1f889af8746";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.onepassword";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs

-(id)isAppExtensionAvailable:(id)unused
{
    return NUMBOOL([[OnePasswordExtension sharedExtension] isAppExtensionAvailable]);
}

-(void)findLoginForURLString:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url;
    KrollCallback *callback;
    
    ENSURE_ARG_FOR_KEY(url, args, @"url", NSString);
    ENSURE_ARG_FOR_KEY(callback, args, @"callback", KrollCallback);
    
    // TODO: Expose "source" to map the "sender" property for bar-buttons
    
    [[OnePasswordExtension sharedExtension] findLoginForURLString:url
                                                forViewController:[[[TiApp app] controller] topPresentedController]
                                                           sender:nil
                                                       completion:^(NSDictionary *loginDictionary, NSError *error) {
                                                           
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{
            @"success": NUMBOOL(error == nil && loginDictionary.count > 0),
            @"error": error ? [error localizedDescription] : [NSNull null],
            @"code": NUMINTEGER(error ? [error code] : -1)
        }];
         
        if (loginDictionary.count > 0) {
            NSString *username = loginDictionary[AppExtensionUsernameKey];
            NSString *password = loginDictionary[AppExtensionPasswordKey];
            NSString *totp = loginDictionary[AppExtensionTOTPKey];
            
            if (username) {
                [event setValue:username forKey:@"username"];
            }
            
            if (password) {
                [event setValue:username forKey:@"password"];
            }
            
            if (totp) {
                [event setValue:totp forKey:@"totp"];
            }
        }
                                                           
       NSArray * invocationArray = [[NSArray alloc] initWithObjects:&event count:1];
       
       [callback call:invocationArray thisObject:self];
       [invocationArray release];
    }];
}

@end
