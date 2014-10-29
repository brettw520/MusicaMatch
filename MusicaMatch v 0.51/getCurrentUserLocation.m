//
//  getCurrentUserLocation.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/28/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "getCurrentUserLocation.h"

@implementation getCurrentUserLocation
{
    CLLocationManager *_locationManager;
    
}

-(void)getUserLocation;
{
    //locate current user
    //instantiate global location variables
    _locationManager = [[CLLocationManager alloc]init];
    
    //use the instantiated global variables to get currentUserLocation
    [_locationManager requestWhenInUseAuthorization]; //get authorization from user to use location
    _locationManager.desiredAccuracy= kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;

}

#pragma mark CLLocation Delegate methods
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.userLocation = newLocation;
    
    [_locationManager stopUpdatingLocation];
    
    [self.delegate currentUserLocationIsReady];
    
}


@end
