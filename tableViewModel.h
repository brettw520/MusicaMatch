//
//  tableViewModel.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 6/8/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getCurrentUserLocation.h"

@protocol tableViewModelProtocol <NSObject>

-(void)usersArrayIsReady;
-(void)currentUserLocationUpdated;

@end



@interface tableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *usersToShow;

@property (nonatomic, weak) id<tableViewModelProtocol> delegate;


-(void)getUserMatches;
-(void)updateCurrentUserLocation;



@end
