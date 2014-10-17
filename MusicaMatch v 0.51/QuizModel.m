//
//  QuizModel.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 5/21/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//


#import "Question.h"
#import "quizModel.h"

@implementation QuizModel
{
    NSMutableData *_downloadedData;
}

-(void)getQuestions
{
    //Download JSON file with questions
    
    //create NSURL object to hold URL of the data set
    NSURL *jsonFileUrl = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/16265962/MusicaMatchNewUserSurveyMultipleResponses.json"];
    
    //create download request
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:jsonFileUrl];
    
    //create NSURL connection
    NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    
}

#pragma mark NSURLConnectionDataDelegate protocol methods


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //connection is established: allocate and initialize array to hold the data
    _downloadedData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //_downloadData is passed the data as the URL is pinged
    [_downloadedData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //now that data is all downloaded, need to organize and parse it
    
    self.questions = [[NSMutableArray alloc]init];
    
    NSError *error;
    NSArray *jsonObject =[NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    //loop through JSONObject and add to questions array
    
    for (int i = 0; i<jsonObject.count; i++)
    {
        
        NSDictionary *jsonElement = jsonObject[i];
        Question *newQuestion = [[Question alloc]init];
        newQuestion.questionText=jsonElement[@"questionText"];
        newQuestion.answers= jsonElement[@"answers"];
        newQuestion.multipleResponses= jsonElement[@"multipleResponses"];
        [self.questions addObject:newQuestion];
        
        //NSLog(@"%@ = %@",newQuestion.questionText, newQuestion.multipleResponses);
    }
    
    //notify delegate that questions are ready
    [self.delegate questionsAreReady]; //this is the alert ping
}

@end
