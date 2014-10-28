//
//  currentUserProfileTableModel.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/26/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "currentUserProfileTableModel.h"
#import <CoreLocation/CoreLocation.h>




@interface currentUserProfileTableModel ()
{
    NSMutableArray *_userElements;
    NSMutableArray *_usageButtons;
}
@end

@implementation currentUserProfileTableModel
-(void)setUpArrays
{
    _userElements = [[NSMutableArray alloc]init];
    
    //setup the profilePhoto Image
    if ([PFUser currentUser][@"profileImage"]==nil)
    {
        UIImageView *profilePhoto = [[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 92, 92)];
        profilePhoto.image = [UIImage imageNamed: @"MyProfilePicSpacer.png"];
        
//set the size
        
        //add the photo to the array
        [_userElements addObject:profilePhoto];
        
    }
    else
    {
        UIImage *profilePhoto = (UIImage *)[PFUser currentUser][@"profileImage"];
        
//set the size
        
        //add the photo to the array
        [_userElements addObject:profilePhoto];
    }
    
    //setup the User's Name label
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", (NSString*)[PFUser currentUser][@"firstName"], (NSString*)[PFUser currentUser][@"lastName"]];
    
    UILabel *firstLastLabel = [[UILabel alloc]init];
    firstLastLabel.text = firstLast;
    
//set attributes of firstLastLabel
    
    [_userElements addObject:firstLastLabel];
    
    //set the location label
    PFGeoPoint *currentUserGeoPoint = [PFUser currentUser][@"location"];
    
    CLLocation *currentUserLocation = [[CLLocation alloc]initWithLatitude:currentUserGeoPoint.latitude longitude:currentUserGeoPoint.longitude];
    
    NSLog(@"complete");
}

- (void)reverseGeocodeLocation:(CLLocation *)location
             completionHandler:(CLGeocodeCompletionHandler)completionHandler
{
    
}

@end
