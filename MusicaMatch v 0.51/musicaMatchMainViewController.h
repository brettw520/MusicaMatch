//
//  musicaMatchMainViewController.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 8/16/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "ViewController.h"
#import "tableViewModel.h"


@interface musicaMatchMainViewController : ViewController <tableViewModelProtocol, UITableViewDelegate, UITableViewDataSource>



@property (strong, nonatomic) IBOutlet UIButton *UICurrentUserLogout;

@end
