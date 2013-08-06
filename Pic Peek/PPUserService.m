//
//  PPUserService.m
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPUserService.h"
#import "KeychainItemWrapper.h"

#define USER_DEFAULTS_CFUUID @"picpeek.user.defaults.cfuuid"

@implementation PPUserService

+ (NSString *)getAppUuid
{
    NSString *uuidStr ;
    
    // Find uuid in user default (common case)
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults valueForKey:USER_DEFAULTS_CFUUID])
    {
        uuidStr = [userDefaults stringForKey:USER_DEFAULTS_CFUUID];
        return uuidStr;
    }
        
    // Find uuid in keychain (it's the first time the user launch the app after a desinstalation)
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:USER_DEFAULTS_CFUUID accessGroup:nil];
    uuidStr = [wrapper objectForKey:(__bridge id)kSecValueData];
    if(uuidStr && ![@"" isEqual:uuidStr]) {
        return uuidStr;
    }
        
    // Create universally unique identifier (it's the first time the app is launch in this device)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidStrRef = CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    uuidStr = (__bridge NSString *)uuidStrRef;
    CFRelease(uuidObject);
    CFRelease(uuidStrRef);

    if ([uuidStr isEqualToString:@""]) {
        uuidStr = @"iPhone Simulator";
    }
    [userDefaults setValue:uuidStr forKey:USER_DEFAULTS_CFUUID];
    [wrapper setObject:uuidStr forKey:(__bridge id)kSecValueData];
    
    return uuidStr;
}


@end
