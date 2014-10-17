//
//  nearMeDetails.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/12/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"

@interface nearMeDetails : UIViewController

@property (strong, nonatomic)Users *userDetails;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *instrumentLabel;

@end
