//
//  musicaMatchMainViewController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 8/16/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//


#import "musicaMatchMainViewController.h"
#import "tableViewModel.h"
#import "Users.h"
#import <Parse/Parse.h>
#import "preAuthenticationViewController.h"


@interface musicaMatchMainViewController ()
{
    tableViewModel *_userMatches;
    NSArray *_usersToShow;
    Users *_selectedUser;
    UIActivityIndicatorView *_spinner;
    //UITableView *_mainTableView;
}
@end

@implementation musicaMatchMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"MMViewController");
    // Do any additional setup after loading the view.
    [self setUsers];
    [self.UICurrentUserLogout addTarget:self action:@selector(currentUserLogout) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)setUsers
{
    _userMatches= [[tableViewModel alloc]init];
    _userMatches.delegate = self;
   
    [_userMatches updateCurrentUserLocation];

    //add spinner to view during loading
    _spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];//create spinning gear object
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    
    
}

/*-(void)viewDidAppear:(BOOL)animated
{
    // _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-80)];
    // _mainTableView.delegate = self;
    // _mainTableView.dataSource = self;
    
    
    //[self.view addSubview:mainTableView];
    
    //returns location of tap...remove when app complete, this is only for testing locations of objects
 
    UITapGestureRecognizer *trackFinger =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(trackPan:)];
    [self.view addGestureRecognizer:trackFinger];
 
    
}*/

//remove trackPan: this is only for testing locations of objects

-(void)trackPan: (UITapGestureRecognizer *)sender
{
    UITapGestureRecognizer *touch= sender;
    CGPoint location = [touch locationInView:touch.view];
    
    NSLog(@"X location: %f", location.x);
    NSLog(@"Y Location: %f", location.y);
    
}

- (void)currentUserLogout
{
    [PFUser logOut];
    
    preAuthenticationViewController *signIn= [[preAuthenticationViewController alloc]init];
    [self presentViewController:(signIn) animated:NO completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark viewModel protocol methods
-(void)usersArrayIsReady
{
    NSLog(@"users Array loaded");
    [_spinner removeFromSuperview];
    //call load table method from here: that method will place a user into each cell
    
}

-(void)currentUserLocationUpdated
{
    
    //get UserMatches
    [_userMatches getUserMatches];
    _usersToShow = _userMatches.usersToShow;
}


#pragma mark Table View Protocol Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //get the user to be shown
    //  Users *user = _usersToShow [indexPath.row];
    
    /*
     //Get references to cell lables
     UILabel *usernameLabel = (UILabel*)[myCell.contentView viewWithTag:1];
     UILabel *instrumentLabel = (UILabel*)[myCell.contentView viewWithTag:2];
     UILabel *locationLabel = (UILabel*)[myCell.contentView viewWithTag: 3];
     //(UILabel*) before property update is called casting.  All it does is say that the property or value to follow will function as the casted type.  (In this case, works without it, just gets rid of the warning.
     */
    //set table cell labels to user data
    /*
     usernameLabel.text = user.username;
     instrumentLabel.text = user.instrument;
     locationLabel.text = user.location;
     */
    return myCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _usersToShow.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected at row %i", indexPath.row);
    
    //set selected user to variable
    _selectedUser = _usersToShow[indexPath.row];
    
    //manually call segue to detail view controller
    [self performSegueWithIdentifier:@"cellSelectionSegue" sender:self];
    //doing this instead (where the whole view controller is pushing, then callin the particular segue insures that this method will finish firing before the next method gets called
}


/*#pragma mark Segue
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 NSLog(@"Segue");
 detailViewController *detailVC = segue.destinationViewController;
 
 detailVC.detailListing = _selectedListing;
 }*/


/*


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
