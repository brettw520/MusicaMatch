//
//  currentUserProfileTableViewController.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/26/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currentUserProfileTableViewController : UITableViewController

# pragma mark Properties list
//Header properties

@property (strong, nonatomic) IBOutlet UISearchBar *profileSearchBar;
@property (strong, nonatomic) IBOutlet UIButton *profileShareButton;

//currentUserElements prototype cell
/*
 profilePhoto = tag 0
 currentUserName = tag 1
 currentUserInstrument = tag 2
 currentUserLocation = tag 3
 editProfileButton = tag 4

*/
//primaryUsageButtons Cell



@end
