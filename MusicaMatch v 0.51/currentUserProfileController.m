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
