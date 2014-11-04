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
    getCurrentUserLocation *_currentLocation; //this object retrieves the new currentLocation
}
@end

@implementation currentUserProfileTableModel

-(void)setUpArrays
{
   // _userElements = [[NSMutableArray alloc]init];
    
    //setup section background image
    UIImageView *userElementsBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 116)];
    userElementsBackground.image = [UIImage imageNamed:(@"MajorUserDetailsBackground.png")];
    [self.userElements addObject:userElementsBackground];
    
    //setup the profilePhoto Image
    if ([PFUser currentUser][@"profileImage"]==nil)
    {
        UIImageView *profilePhoto = [[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 92, 92)];
        profilePhoto.image = [UIImage imageNamed: @"MyProfilePicSpacer.png"];
        //set the size of ProfilePhoto
        
        
        //add the photo to the array
        [self.userElements addObject:profilePhoto];
        
    }
    else
    {
        UIImage *profilePhoto = (UIImage *)[PFUser currentUser][@"profileImage"];
        //set the size of profilePhoto
        
        
        //add the photo to the array
        [self.userElements addObject:profilePhoto];
    }
    
    //setup the User's Name label
    {
    NSString *firstLast = [NSString stringWithFormat:@"%@ %@", (NSString*)[PFUser currentUser][@"firstName"], (NSString*)[PFUser currentUser][@"lastName"]];

            //create firstLastLabel
            UILabel *firstLastLabel = [[UILabel alloc]init];
            
            //set the label text
            firstLastLabel.text = firstLast;
            
        #warning set attributes of firstLastLabel including size
            
            [self.userElements addObject:firstLastLabel];
    }
    
    //setup the location label
    {
    NSString *location= [NSString stringWithFormat:@"%@, %@", [PFUser currentUser][@"City"], [PFUser currentUser][@"State"]];
    

            //create locationLabel
            UILabel *locationLabel = [[UILabel alloc]init];
            locationLabel.text= location;
            #warning set attributes of locationLabel including size
            [self.userElements addObject:locationLabel];
            

    
    //setup the editProfileButton
    {
    UIButton *editProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editProfileImage = [UIImage imageNamed:@"Pencil Icon.png"];
    [editProfileButton setTitle:@"" forState:UIControlStateNormal];
    [editProfileButton setBackgroundImage:editProfileImage forState:UIControlStateNormal];
    editProfileButton.frame = CGRectMake(247, 70, 59, 36);
    [_userElements addObject:editProfileButton];
    
    
    }
        
    NSLog(@"completed setting array");
}
}

-(void)setCurrentUserLocation
{
    _currentLocation =[[getCurrentUserLocation alloc]init];
    _currentLocation.delegate = self; //set the delegate before calling the protocol
    [_currentLocation getUserLocation];
}

#pragma mark getCurrentUserLocationDelegate methods

-(void)currentUserLocationIsReady
{
    CLLocation *newLocation =_currentLocation.userLocation;
    PFGeoPoint *tempGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    [PFUser currentUser][@"location"]=tempGeoPoint;
    
    //reverse geoCoding
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error==nil && [placemarks count]>0)
         {
             //store string variables with geolocation data
             CLPlacemark *tempPlacemark = [placemarks lastObject];
             NSString *city = [NSString stringWithFormat:@"%@", tempPlacemark.subLocality];
             NSString *state = [NSString stringWithFormat:@"%@",tempPlacemark.administrativeArea];
             
             //Save the string variables to Parse
             [PFUser currentUser][@"City"]=city;
             [PFUser currentUser][@"formattedAddress"]=tempPlacemark.addressDictionary[@"FormattedAddressLines"];
             [PFUser currentUser][@"State"] = state;
             
             [[PFUser currentUser]saveInBackground];
         }
         
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
     }];
}

@end
