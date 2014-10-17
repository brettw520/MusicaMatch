//
//  Question.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 5/22/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, strong) NSMutableArray *answers;
@property (nonatomic, strong) NSString *questionText;
@property (nonatomic) NSNumber *multipleResponses;


-(id)init;
@end