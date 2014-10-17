//
//  AppDelegate.m
//  MusicaMatch v0.52
//
//  Created by Brett Walfish on 4/27/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "AppDelegate.h"
#import "preAuthenticationViewController.h"
#import <Parse/Parse.h>
#import "surveyController.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"ic2rfhinSvMDTwoMYmz9ptGygKyqgzCxvcrLdy7q" clientKey:@"rrbjMVuZ9KBeHIfhm5B3Ikaqy9rGguThoKuSHm95"];
    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"Bmhib4GvypppNUNftj9lRCE6H" consumerSecret:@"1YK2fEbTfzfntDYUKtDj5bTqO0TrZmHhO6PX45G794pHmSwLCp"];
    
    
    
    // Set default ACLs
    //This sets the various permissions
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[preAuthenticationViewController alloc] init]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

// Facebook oauth callback
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Handle an interruption during the authorization flow, such as the user clicking the home button.
    [FBSession.activeSession handleDidBecomeActive];
}

@end
