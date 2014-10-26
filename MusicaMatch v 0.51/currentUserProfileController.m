//
//  currentUserProfileController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 10/13/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "currentUserProfileController.h"
#import "Users.h"
#import <Parse/Parse.h>

@interface currentUserProfileController ()
{
    Users *_currentUser;
}
@end

@implementation currentUserProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#warning make this dynamic
    self.profileScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    
   // self.currentUserTableVIew.delegate = self;
   // self.currentUserTableVIew.dataSource = self;
    
    self.profileSearchBar.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //create gesture responder to dismiss first responder
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    _currentUser.firstName = [PFUser currentUser][@"firstName"];
    _currentUser.lastName = [PFUser currentUser][@"lastName"];
    _currentUser.musicalMentors = [PFUser currentUser][@"musicalMentors"];
    //[PFUser currentUser][@""];
    
}

-(void)dismissKeyboard
{
    [self.profileSearchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UISearch Bar Protocols
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return TRUE;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return TRUE;
}



#pragma mark tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected at row %li", (long)indexPath.row);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"userData";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *mentorsLabel = (UILabel *)[cell.contentView viewWithTag:0];
    
    mentorsLabel.text = _currentUser.musicalMentors[0];
 
    return cell;
 
    
    // Configure the cell...
    //Cells will contain...
    /*
     1.  Newly discovered colleagues
        a.  Information about the User
            1.  Name
            2.  Instrument
            3.  Location
        b.  See all button (array of multiple users)
     
     2. Education
        a.  Degree array (flexible spacing, 1 line per degree...can have multiple degrees)[index path]
        b.  Teachers seperated by a comma

     3. Summer Festivals attended
     4. Competitions placed
     5. Collaborations to Note
     6. Institutions of employment
     
     7.  Favorite Composers
        pieces
        movies
        non-musical past-times
     
    */
    
    //set the cell to display the data
    
    
 
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
