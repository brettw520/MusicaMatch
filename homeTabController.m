//
//  homeTabController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 9/28/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "homeTabController.h"
#import <Parse/Parse.h>
#import "preAuthenticationViewController.h"


@interface homeTabController ()

@end

@implementation homeTabController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Home Tab loaded");
}
- (IBAction)logoutButtonClicked:(id)sender
{
    [PFUser logOut];
    
    preAuthenticationViewController *signIn= [[preAuthenticationViewController alloc]init];
    [self presentViewController:(signIn) animated:NO completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
