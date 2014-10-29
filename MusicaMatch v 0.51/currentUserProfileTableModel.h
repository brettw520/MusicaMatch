//
//  currentUserProfileTableModel.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/26/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "getCurrentUserLocation.h"

@interface currentUserProfileTableModel : NSObject <CLLocationManagerDelegate, getCurrentUserLocationDelegate>

-(void)setUpArrays;
-(void)setCurrentUserLocation;

@end