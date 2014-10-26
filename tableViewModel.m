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

@implementation tableViewModel

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
    NSLog(@"tableViewModel.m updateCurrentUserLocation");
    
    //locate current user
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error)
    {
        NSLog(@"in geoPoint block");
        
        if (!error)
        {
            // do something with the new geoPoint
            
            [PFUser currentUser][@"location"]=geoPoint;
            [[PFUser currentUser] saveInBackground];
        }
        [self.delegate currentUserLocationUpdated]; //notifies delegate that currentUser has been updated

    }];
    
//REMOVE ONCE LOCACTION WORKS AGAIN: this negates actually getting user location for current time
    [self.delegate currentUserLocationUpdated];
    
}


-(void)getUserMatches //query to populate relevant data
{
    //initialize usersToShow
    self.usersToShow = [[[NSMutableArray alloc]init]mutableCopy];
    
    double distanceFromCurrentUser = 10; // to be read in from PFUser's choices
    
    PFGeoPoint *currentUserLocation = [PFUser currentUser][@"location"];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" notEqualTo:@""];
    [query whereKey:@"username" notEqualTo:[PFUser currentUser][@"username"]];
    //[query whereKey:@"surveyComplete" equalTo:@YES];  No longer using survey!
    [query whereKey:@"location" nearGeoPoint:currentUserLocation withinMiles:distanceFromCurrentUser];
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

@end
