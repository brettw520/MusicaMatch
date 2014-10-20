//
//  currentUserProfileController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/13/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "currentUserProfileController.h"

@interface currentUserProfileController ()

@end

@implementation currentUserProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    
    self.profileSearchBar.delegate=self;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //create gesture responder to dismiss first responder
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard
{
    [self.profileSearchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UISearch Bar Protocols
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return TRUE;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return TRUE;
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
