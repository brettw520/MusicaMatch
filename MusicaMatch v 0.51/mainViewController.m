//
//  mainViewController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 5/3/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "mainViewController.h"
#import "preAuthenticationViewController.h"
#import <Parse/Parse.h>

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    //logout button
    {
        UIButton *logOut = [UIButton buttonWithType:UIButtonTypeSystem];
        [logOut setTitle:@"Log Out" forState:UIControlStateNormal];
        logOut.frame = CGRectMake(self.view.frame.size.width-80, self.view.frame.size.height-30, 60, 30);
        [logOut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logOut];
    }
    
   /* self.view.backgroundColor=[UIColor cyanColor];
    
    
    //create scrollView
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-140)];
    scroll.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:scroll];
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    testLabel.text=@"Test Label";
    [scroll addSubview:testLabel];*/
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut
{
    [PFUser logOut];
    preAuthenticationViewController *signIn = [[preAuthenticationViewController alloc]init];
    [self.navigationController setViewControllers:@[signIn] animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
