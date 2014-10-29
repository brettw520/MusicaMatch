//  tableViewModel.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 6/8/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "tableViewModel.h"
#import <Parse/Parse.h>
#import "ViewController.h"
#import "Users.h"
#import "getCurrentUserLocation.h"
#import <CoreLocation/CoreLocation.h>

@implementation tableViewModel
{
    getCurrentUserLocation *_userLocation;
    double _distanceFromCurrentUser;
    
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        self.usersToShow = [[[NSMutableArray alloc]init]mutableCopy];
        
    }
    return self;
}


//****Be careful not to load too many users at a time****, allow the user to scroll down to load more data

-(void)updateCurrentUserLocation
{
    _userLocation =[[getCurrentUserLocation alloc]init];
    [_userLocation getUserLocation];
    _userLocation.delegate = self;
    
}

-(void)getUserMatches //query to populate relevant data
{
    //initialize usersToShow
    self.usersToShow = [[[NSMutableArray alloc]init]mutableCopy];
    
    _distanceFromCurrentUser = 10; // to be read in from PFUser's choices
    
    PFGeoPoint *currentUserLocation = [PFGeoPoint geoPointWithLatitude:_userLocation.userLocation.coordinate.latitude longitude:_userLocation.userLocation.coordinate.longitude];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" notEqualTo:@""];
    [query whereKey:@"username" notEqualTo:[PFUser currentUser][@"username"]];
    [query whereKey:@"location" nearGeoPoint:currentUserLocation withinMiles:_distanceFromCurrentUser];
    //all query parameters are now set
    
    //run the query
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        {
            if (!error)
            {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu users.", (unsigned long)objects.count);
                // Do something with the found objects
                for (PFObject *object in objects)
                {
                    Users *tempUser=[[Users alloc]init];
                    
                    tempUser.objectId = object.objectId;
                    tempUser.username = object [@"username"];
                   // tempUser.authData = object [@"_authData"];
                    tempUser.phoneNumber = object [@"_additional"];
                    tempUser.instrument= object[@"Instrument"];
                    tempUser.location = object[@"location"];
                    //tempUser.userName = object[@"MusicaMatchScore"];

                    
                    [self.usersToShow addObject:tempUser];
                        //this adds a parse object to the array: all parse functionality can now be called on each index.
                }
            }
            else
            {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [self.delegate usersArrayIsReady]; //sets the delegate method to alert
        }
    ];
}

#pragma mark getCurrentUserLocation delegate method
-(void)currentUserLocationIsReady
{
    /*
    CLLocation *userNewLocation = _userLocation.userLocation;
     
    //update location in Parse
    PFGeoPoint *newLocation= [PFGeoPoint geoPointWithLatitude:userNewLocation.coordinate.latitude longitude:userNewLocation.coordinate.longitude];
    [PFUser currentUser][@"location"] = newLocation;
    
    //save the parse update
    [[PFUser currentUser]saveInBackground];
    */
    
    [self.delegate currentUserLocationUpdated];
    
}



@end
