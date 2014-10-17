//
//  Question.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 5/22/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        self.answers = [[NSMutableArray alloc]init];
        
    }
    return self;
}

@end