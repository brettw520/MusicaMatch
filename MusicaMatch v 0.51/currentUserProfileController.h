//
//  currentUserProfileController.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/13/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currentUserProfileController : UIViewController <UIBarPositioningDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *ProfileheaderImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *profileScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *profileShareButton;
@property (strong, nonatomic) IBOutlet UISearchBar *profileSearchBar;


@end
