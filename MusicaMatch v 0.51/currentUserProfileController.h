//
//  currentUserProfileController.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/13/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface currentUserProfileController : UIViewController <UIBarPositioningDelegate>

//Header Properties
@property (strong, nonatomic) IBOutlet UISearchBar *profileSearchBar;

//Major User Details Properties
@property (strong, nonatomic) IBOutlet UIImageView *currentUserProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentUserInstrumentLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentUserLocationLabel;


//Body Properties
@property (strong, nonatomic) IBOutlet UIScrollView *profileScrollView;

//TableView
@property (strong, nonatomic) IBOutlet UITableView *currentUserTableVIew;

@end
