//
//  currentUserProfileTableModel.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/26/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "currentUserProfileTableModel.h"

@interface currentUserProfileTableModel ()
{
    NSMutableArray *_userElements;
    NSMutableArray *_usageButtons;
    getCurrentUserLocation *_updateCurrentLocation; //this object retrieves the new currentLocation
}
@end

@implementation currentUserProfileTableModel

-(void)setUpArrays
{
    _updateCurrentLocation = [[getCurrentUserLocation alloc]init];
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

    
    
}

-(void)setCurrentUserLocation
{
    _updateCurrentLocation = [[getCurrentUserLocation alloc]init];
    [_updateCurrentLocation getUserLocation];
    _updateCurrentLocation.delegate = self;
      
}

#pragma mark getCurrentUserLocationDelegate methods

-(void)currentUserLocationIsReady
{
    CLLocation *newLocation =_updateCurrentLocation.userLocation;
    PFGeoPoint *tempGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    [PFUser currentUser][@"location"]=tempGeoPoint;
    //choosing not to save here: want to save everything in 1 saveinbackground message
    
    //now set up the city name as a parse object
    //reverse geoCoding
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error==nil && [placemarks count]>0)
         {
             CLPlacemark *tempPlacemark = [placemarks lastObject];
             NSString *city = [NSString stringWithFormat:@"%@", tempPlacemark.subLocality];
             NSLog(@"%@",city);
                               
         }
         
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
     }];

    
}

@end
