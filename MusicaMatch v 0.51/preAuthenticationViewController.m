//
//  ViewController.m
//  MusicaMatch v0.51
//
//  Created by Brett Walfish on 4/27/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "preAuthenticationViewController.h"
#import "musicaMatchLoginViewController.h"
#import "musicaMatchSignupViewController.h"

@implementation preAuthenticationViewController

#pragma mark View Controller methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[PFUser logOut];
    
    if ([PFUser currentUser])
    {
        // If the user is logged in, show their name in the welcome label.
        
        if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]])
        {
            // If user is linked to Twitter, we'll use their Twitter screen name
            NSLog(@"User is now logged in using Twitter handle %@", [PFTwitterUtils twitter].screenName);
            
             [self viewControl];
            
        }
        else if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
        {
            // If user is linked to Facebook, we'll use the Facebook Graph API to fetch their full name. But first, show a generic Welcome label.
            
            // Create Facebook Request for user's details
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
             {
                 // This is an asynchronous method. When Facebook responds, if there are no errors, we'll NSLog it.
                 if (!error)
                 {
                     NSString *displayName = result[@"name"];
                     if (displayName)
                     {
                         NSString *fbLoginSuccessful =[NSString stringWithFormat:NSLocalizedString(@"Facebook User %@ is now successfully logged in!", nil),displayName];
                         NSLog(@"%@", fbLoginSuccessful);
                         
                          [self viewControl];
                         
                     }
                 }
             }];
            
        }
        else
        {
            // If user is linked to neither, let's use their username for the Welcome label.
           
            //NSLog(@"Parse user %@ succesfully logged in", [PFUser currentUser].username);
            
            [self viewControl];
            
            
        }
    }
    else
    {
        NSLog(@"User Not Logged in at load");
    }
     
}

- (void)viewControl
{
    //transition to proper viewController
    [[PFUser currentUser]refreshInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         
            // Chris: because you had two storyboards, you need an extra IF statement for the name
             // The storyboard name is the name of the storyboard file minus the ".storyboard"
             NSString * storyboardName;
             
             if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
             {
                 storyboardName = @"Main_iPad";
             }
             else
             {
                 storyboardName = @"Main_iPhone";
             }
             
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
             
             // Chris: Now instantiate the viewcontroller with the View controller id
             UITabBar * vc = [storyboard instantiateViewControllerWithIdentifier:@"musicaMatchMainViewController"];
             
            [self presentViewController:vc animated:YES completion:NULL];

     }];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    // Check if user is logged in
    if (![PFUser currentUser])
    {
        // Customize the Log In View Controller
        musicaMatchLoginViewController *logInViewController = [[musicaMatchLoginViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = @[@"friends_about_me"];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
        
        // Customize the Sign Up View Controller
        musicaMatchSignupViewController *signUpViewController = [[musicaMatchSignupViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
        logInViewController.signUpController = signUpViewController;
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if (username && password && username.length && password.length)
    {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    
    return NO;
}

// Sent to the delegate when a PFUser is logged in. **login Successful** Dismiss LoginViewController**
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    NSLog(@"User dismissed the logInViewController");
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete)
    {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - ()

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
