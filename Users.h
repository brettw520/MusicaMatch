//
//  Users.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 6/8/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
//#import "Degree.h"

@interface Users : NSObject

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *authData;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) NSString *instrument;
@property (nonatomic, strong) NSMutableArray *education; // This array to store objects of Degree.h
@property (nonatomic,strong) NSMutableArray *musicalMentors;
@property (nonatomic,strong)NSMutableArray *competitionsPlaced;
@property (nonatomic,strong)NSMutableArray *festivalsAttended;
@property (nonatomic,strong) NSMutableArray *whereFaculty;
@property (nonatomic, strong) NSMutableArray *professionalEnsembles;
@property (nonatomic, strong) NSMutableArray *genresOfInterest;
@property (nonatomic, strong)NSMutableArray *messagesFromOtherUsers;
@property (nonatomic, strong)NSMutableArray *messagesToOtherUsers;
@property (nonatomic, strong) PFGeoPoint *location;



@end
