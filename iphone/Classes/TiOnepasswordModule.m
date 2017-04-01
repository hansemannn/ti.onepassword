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
- (id)moduleGUID
{
	return @"3506d384-99f9-409f-a4f3-a1f889af8746";
}

// this is generated for your module, please do not change it
- (NSString *)moduleId
{
	return @"ti.onepassword";
}

#pragma mark Lifecycle

- (void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs

- (id)isAppExtensionAvailable:(id)unused
{
    return NUMBOOL([[OnePasswordExtension sharedExtension] isAppExtensionAvailable]);
}

- (void)findLoginForURLString:(id)args
{
    ENSURE_UI_THREAD(findLoginForURLString, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url;
    KrollCallback *callback;
    
    ENSURE_ARG_FOR_KEY(url, args, @"url", NSString);
    ENSURE_ARG_FOR_KEY(callback, args, @"callback", KrollCallback);
    
    [[OnePasswordExtension sharedExtension] findLoginForURLString:url
                                                forViewController:[[[TiApp app] controller] topPresentedController]
                                                           sender:[TiOnepasswordModule senderFromSourceView:[args objectForKey:@"source"]]
                                                       completion:^(NSDictionary *loginDictionary, NSError *error) {
                                                           
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{
            @"success": NUMBOOL(error == nil && loginDictionary.count > 0)
        }];
                                                           
        if (error) {
            [event setValue:[error localizedDescription] forKey:@"error"];
            [event setValue:[error code] forKey:@"code"];
        }
         
        if (loginDictionary.count > 0) {            
            [event setValue:loginDictionary forKey:@"credentials"];
        }
                                                           
       NSArray * invocationArray = [[NSArray alloc] initWithObjects:&event count:1];
       
       [callback call:invocationArray thisObject:self];
       [invocationArray release];
    }];
}

- (void)storeLoginForURLString:(id)args
{
    ENSURE_UI_THREAD(storeLoginForURLString, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url;
    KrollCallback *callback;
    NSDictionary *credentials;
    NSDictionary *options;
    
    ENSURE_ARG_FOR_KEY(url, args, @"url", NSString);
    ENSURE_ARG_FOR_KEY(callback, args, @"callback", KrollCallback);
    ENSURE_ARG_FOR_KEY(credentials, args, @"credentials", NSDictionary);
    ENSURE_ARG_OR_NIL_FOR_KEY(options, args, @"options", NSDictionary);
    
    [[OnePasswordExtension sharedExtension] storeLoginForURLString:url
                                                      loginDetails:credentials
                                         passwordGenerationOptions:options
                                                 forViewController:[[[TiApp app] controller] topPresentedController]
                                                            sender:[TiOnepasswordModule senderFromSourceView:[args objectForKey:@"source"]]
                                                        completion:^(NSDictionary *loginDictionary, NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{
            @"success": NUMBOOL(error == nil && loginDictionary.count > 0)
        }];
        
        if (error) {
            [event setValue:[error localizedDescription] forKey:@"error"];
            [event setValue:[error code] forKey:@"code"];
        }
        
        if (loginDictionary.count > 0) {
            [event setValue:loginDictionary forKey:@"credentials"];
        }
                                                            
        NSArray * invocationArray = [[NSArray alloc] initWithObjects:&event count:1];
        
        [callback call:invocationArray thisObject:self];
        [invocationArray release];
    }];
}

- (void)changePasswordForLoginForURLString:(id)args
{
    ENSURE_UI_THREAD(changePasswordForLoginForURLString, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url;
    KrollCallback *callback;
    NSDictionary *credentials;
    NSDictionary *options;
    
    ENSURE_ARG_FOR_KEY(url, args, @"url", NSString);
    ENSURE_ARG_FOR_KEY(callback, args, @"callback", KrollCallback);
    ENSURE_ARG_FOR_KEY(credentials, args, @"credentials", NSDictionary);
    ENSURE_ARG_OR_NIL_FOR_KEY(options, args, @"options", NSDictionary);
    
    [[OnePasswordExtension sharedExtension] changePasswordForLoginForURLString:url
                                                      loginDetails:credentials
                                         passwordGenerationOptions:options
                                                 forViewController:[[[TiApp app] controller] topPresentedController]
                                                            sender:[TiOnepasswordModule senderFromSourceView:[args objectForKey:@"source"]]
                                                        completion:^(NSDictionary *loginDictionary, NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{
            @"success": NUMBOOL(error == nil && loginDictionary.count > 0)
        }];
        
        if (error) {
            [event setValue:[error localizedDescription] forKey:@"error"];
            [event setValue:[error code] forKey:@"code"];
        }
        
        if (loginDictionary.count > 0) {
            [event setValue:loginDictionary forKey:@"credentials"];
        }
        
        NSArray * invocationArray = [[NSArray alloc] initWithObjects:&event count:1];
        
        [callback call:invocationArray thisObject:self];
        [invocationArray release];
    }];
}

+ (id)senderFromSourceView:(id)value
{
    ENSURE_TYPE_OR_NIL(value, TiViewProxy);
    
    if (!value) {
        return nil;
    }
    
    if ([value supportsNavBarPositioning] && [value isUsingBarButtonItem]) {
        return  [value barButtonItem];
    }
    
    return [value view];
}

@end
