//
//  nearMeController.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 9/28/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewModel.h"

@interface nearMeController : UITableViewController <tableViewModelProtocol, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
