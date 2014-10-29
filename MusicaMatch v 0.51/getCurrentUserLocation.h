//
//  getCurrentUserLocation.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/28/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol getCurrentUserLocationDelegate <NSObject>

-(void)currentUserLocationIsReady;

@end


@interface getCurrentUserLocation : NSObject <CLLocationManagerDelegate>


@property (nonatomic, weak) id<getCurrentUserLocationDelegate> delegate;

@property (nonatomic, strong)CLLocation *userLocation;

-(void)getUserLocation;

@end
