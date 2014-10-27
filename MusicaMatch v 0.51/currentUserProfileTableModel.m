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
}
@end

@implementation currentUserProfileTableModel
-(void)setUpArrays
    {
        //setup the profilePhoto Image
        if ([PFUser currentUser][@"profileImage"]==nil)
        {
            UIImage *profilePhoto = [UIImage imageNamed:@"MyProfilePicSpacer"];
            
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
        
        
    }





@end
