//
//  QuizModel.h
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 5/22/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol quizModelProtocol <NSObject>

-(void)questionsAreReady;

@end


@interface QuizModel : NSObject <NSURLConnectionDataDelegate>

@property (strong,nonatomic) NSMutableArray *questions;

@property (nonatomic, weak) id<quizModelProtocol> delegate;

-(void)getQuestions;

@end
