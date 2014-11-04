//
//  nearMeController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 9/28/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "nearMeController.h"
#import "tableViewModel.h"
#import "Users.h"
#import <Parse/Parse.h>
#import "nearMeDetails.h"


@interface nearMeController ()
{
    tableViewModel *_userMatches;
    NSArray *_usersToShow; //array of users within current user's chosen proximity distance.
    Users *_selectedUser;
    UIActivityIndicatorView *_spinner;
}
@end

@implementation nearMeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"nearMe Loaded");
    
    [self setUsers];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     
}

-(void)setUsers
{
    _userMatches = [[tableViewModel alloc]init];
    _userMatches.delegate = self;
    
    //continue with tableView setup here
    [_userMatches updateCurrentUserLocation];
    
    //add spinner to view during loading
    _spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];//create spinning gear object
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    return _usersToShow.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected at row %li", (long)indexPath.row);
    
    _selectedUser = _usersToShow[indexPath.row];
    
    //set selected listing to do something
    [self performSegueWithIdentifier:@"nearMeDetailsSegue" sender:self];
    
}

#pragma mark tableViewModelProtocol Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"BasicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    
    Users *tableUser = _usersToShow[indexPath.row]; //this populates each row with a user's object id
    
    //setup the cell now to display user info
    //use tags
    
    UIImage *userImage = (UIImage *) [cell.contentView viewWithTag:0];
    UILabel *usernameLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *instrumentLabel = (UILabel*)[cell.contentView viewWithTag:2];
    UILabel *locationLabel = [(UILabel*)cell.contentView viewWithTag:3];
    
    usernameLabel.text = tableUser.username;    
    instrumentLabel.text = tableUser.instrument;
    locationLabel.text = [NSString stringWithFormat:@"%@, %@", tableUser.city, tableUser.state];
    // userImage.imageAsset
    
    
    return cell;
}


#pragma Mark Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *usernameOfSegue = [[NSString alloc]init];
    usernameOfSegue = (NSString*) _selectedUser.username;
    
    nearMeDetails *detailsVC = segue.destinationViewController;
    detailsVC.userDetails = _selectedUser;
    
    NSLog(@"Segue to %@", usernameOfSegue);
}


#pragma mark UsersArray from Parse ready

-(void)usersArrayIsReady
{
    NSLog(@"Users Array Loaded");
    [_spinner removeFromSuperview];
    
    [self.tableView reloadData];
    
}

-(void)currentUserLocationUpdated
{
    //get userMatches
    [_userMatches getUserMatches]; //fills _userMatches array with getUserMatches data
    _usersToShow = _userMatches.usersToShow;
}



@end
