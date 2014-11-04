//
//  currentUserProfileTableViewController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/26/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "currentUserProfileTableViewController.h"
#import "Users.h"
#import <Parse/Parse.h>
#import "currentUserProfileTableModel.h"
#import "Degree.h"



@interface currentUserProfileTableViewController ()
{
    Users *_currentUser;
    currentUserProfileTableModel *_userModel;
}
@end

@implementation currentUserProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCurrentUserPersonalData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setupCurrentUserPersonalData
{
    _currentUser = [[Users alloc]init];
    PFObject *current = [PFUser currentUser];
    
    
    //define the User elements for _currentUser
    _currentUser.objectId = current [@"objectId"];
     _currentUser.username = current[@"username"];
    _currentUser.firstName = current[@"firstName"];
    _currentUser.lastName = current[@"lastName"];
    _currentUser.instrument = current[@"Instrument"];
    _currentUser.schoolsAndDegrees = current[@"schoolsAndDegrees"];//stores degrees objects
    _currentUser.city = current[@"City"];
    _currentUser.state = current[@"State"];
    _currentUser.location = current[@"location"];
   
    _currentUser.musicalMentors= current[@"musicalMentors"];
    _currentUser.competitionsPlaced = current[@"competitionsPlaced"];
    _currentUser.festivalsAttended = current[@"festivalsAttended"];
    _currentUser.professionalEnsembles = current[@"professionalEsnsembles"];
   
    
    [self confirmUserData];

}

- (IBAction)profileShareButtonClicked:(id)sender
{
    //temporary code to check arrays are set up correctly in the currentUserProfileTableModel
    
    _userModel = [[currentUserProfileTableModel alloc]init];
    [_userModel setUpArrays];
    
    //End of testing code
    
    //this method will need to go into editProfile
    //update location
    [_userModel setCurrentUserLocation];
    
}


-(void)confirmUserData
{
    NSString *userDataConfirmed =[NSString stringWithFormat:@"first name: %@, last name: %@, instrument: %@, city: %@, state: %@", _currentUser.firstName, _currentUser.lastName, _currentUser.instrument, _currentUser.city, _currentUser.state];
    
    NSLog(@"curentUserProfileTableViewController confirms user data:\n%@",userDataConfirmed);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (section == 0)
    {
        return 1;
    }
    else if (section ==1)
    {
        return 1;
    }
    else
    {
        return 5;
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileData" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)profileShareButton:(id)sender
{

}
    
@end
