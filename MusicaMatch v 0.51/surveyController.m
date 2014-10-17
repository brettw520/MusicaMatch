//
//  surveyController.m
//  MusicaMatch v 0.52
//
//  Created by Brett Walfish on 4/29/14.
//  Copyright (c) 2014 Brett Walfish. All rights reserved.
//

#import "surveyController.h"
#import <Parse/Parse.h>
#import "preAuthenticationViewController.h"
#import "QuizModel.h"
#import "Question.h"
#import "musicaMatchMainView.h"
#import "Users.h"


@interface surveyController ()
{
    //the following load the questions and quizmodel
    NSMutableArray *_questionsArray;
    Question *_currentQuestion;
    QuizModel *_quizModel;
    UIActivityIndicatorView *_spinner;
    
    //the following will store user input
    NSMutableArray *_answerCollectionArray; //every answer is stored in this array to be processed in algorithm later
    int _QPI; //question progress index
    
    //the following are UIObjects
    NSMutableArray *_labelStorage; //every label on screen must be included in this array
    NSMutableArray *_buttonsCreated; //every button created by buttons created method stores its buttons in this array in order to be found by the caller
    UIPickerView *_answerPicker;
    
    UITextField *_textAnswer; //text field from user Input
    NSMutableArray *_pickerSelections; //stores each picker selection before actual submission
    NSMutableArray *_multipleAnswersArray; //stores answer values from UITextField when multiple responses = 1
    
}

@end

@implementation surveyController

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
    // Do any additional setup after loading the view.
    
    //NSLog(@"Survey Loaded");
    
    //initialize constants
    _answerCollectionArray =[[[NSMutableArray alloc]init] mutableCopy]; //stores user's answers
    _labelStorage = [[[NSMutableArray alloc]init]mutableCopy];
    _buttonsCreated = [[[NSMutableArray alloc]init] mutableCopy];
    _pickerSelections=[[[NSMutableArray alloc]init]mutableCopy];
    _multipleAnswersArray = [[[NSMutableArray alloc]init]mutableCopy];
    
    
    //begin Survey
    [self hideLabelsAndButtons];
    [self setQuestions];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideLabelsAndButtons
{
    
    for (int i=0; i<_labelStorage.count; i++) //remove labels from view
    {
        [_labelStorage[i] removeFromSuperview];
    }
    [_labelStorage removeAllObjects];
    
    //remove buttons from view
    for (int x =0; x<_buttonsCreated.count; x++)
    {
        [_buttonsCreated[x] removeFromSuperview];
    }
    [_buttonsCreated removeAllObjects];
    
    //remove _textAnswer
    [_textAnswer removeFromSuperview];
    
    //remove _answerPicker from view and dump _pickerSelections memory
    [_answerPicker removeFromSuperview];
    [_pickerSelections removeAllObjects];
    
    //clear contents of _multipleAnswersArray
    [_multipleAnswersArray removeAllObjects];
    
}

-(void)setQuestions
{
    _quizModel = [[QuizModel alloc]init];
    _quizModel.delegate=self;
    
    //Get Questions
    [_quizModel getQuestions];
    _spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];//create spinning gear object
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error)
        {
            // do something with the new geoPoint
            [PFUser currentUser][@"location"] = geoPoint;
            [[PFUser currentUser] saveEventually];
        }
    }];
    
}

-(void)setQuestionView
{
    [self hideLabelsAndButtons];
    
    [self createLabel:self.view.frame.size.width/2-150 :60 :300 :120 :0 :_currentQuestion.questionText];
    [self.view addSubview:_labelStorage.lastObject]; //question label
    
    //determine type of question: textField, multiple choice, or pickerView
    //textfield answer
    if (_currentQuestion.answers.count==1)
    {
        //create UITextField for user input
        _textAnswer = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 315, 300, 30)];
        _textAnswer.textAlignment=NSTextAlignmentCenter;
        _textAnswer.placeholder = @"Press Enter Between Entries";
        _textAnswer.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self.view addSubview:_textAnswer];
        
        //create gesture responder to dismiss first responder
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
        
        
        if (_currentQuestion.multipleResponses == [NSNumber numberWithInt:0])
        {
            //create submit button
            [self createButtonTouchUpInside:self.view.frame.size.width/2-150 :360 :300 :30 :@"Submit"];
            [_buttonsCreated.lastObject addTarget:self action:@selector(submitButtonClickedTextField) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:_buttonsCreated.lastObject];
            
            //call submitButtonClicked with enter/return key
            _textAnswer.delegate=self;
        }
        else
        {
            if (_currentQuestion.multipleResponses== [NSNumber numberWithLong:1])
            {
                //create NA button
                [self createButtonTouchUpInside:self.view.frame.size.width/2-55 :390 :110 :30 :@"Not Applicable"];
                [_buttonsCreated.lastObject addTarget:self action:@selector(naClicked) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_buttonsCreated.lastObject];
                
                //create add answer button
                [self createButtonTouchUpInside:self.view.frame.size.width/2-50 :360 :100 :30 :@"Add Another"];
                [_buttonsCreated.lastObject addTarget:self action:@selector(addAnotherTextAnswer) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_buttonsCreated.lastObject];
                
                //create submitButton
                [self createButtonTouchUpInside:self.view.frame.size.width/2-50 :420 :100 :30 :@"Submit"];
                [_buttonsCreated.lastObject addTarget:self action:@selector(submitButtonClickedTextField) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_buttonsCreated.lastObject];
                
                //call submitButtonClicked with enter/return key
                _textAnswer.delegate=self;

            }
            else
            {
            
                //create add answer button
                [self createButtonTouchUpInside:self.view.frame.size.width/2-150 :360 :300 :30 :@"Add another Answer"];
                [_buttonsCreated.lastObject addTarget:self action:@selector(addAnotherTextAnswer) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_buttonsCreated.lastObject];
                
                //create submitButton
                [self createButtonTouchUpInside:self.view.frame.size.width/2-150 :390 :300 :30 :@"Submit"];
                [_buttonsCreated.lastObject addTarget:self action:@selector(submitButtonClickedTextField) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_buttonsCreated.lastObject];
                
                //call submitButtonClicked with enter/return key
                _textAnswer.delegate=self;
            }
        }
    }
    
    //multiple Choice and True False
    else if (_currentQuestion.answers.count>=2 && _currentQuestion.answers.count<5)
    {
        for (int i = 0; i <_currentQuestion.answers.count; i++) //set the answer buttons
        {
            [self createButtonTouchUpInside:self.view.frame.size.width/2-150 :i*40+220 :300 :30 :_currentQuestion.answers[i]];
            [_buttonsCreated.lastObject addTarget:self action:@selector(answerClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *buttonTest = [[UIButton alloc]init];
            buttonTest = _buttonsCreated.lastObject;
            buttonTest.tag= i;
            [_buttonsCreated addObject:buttonTest];
             
            [self.view addSubview:_buttonsCreated.lastObject];
            
        }
    }
    //picker View
    else
    {
        //setup Picker View
        _answerPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 150, 320, 300)];
        _answerPicker.delegate=self;
        _answerPicker.showsSelectionIndicator = YES;
        [_pickerSelections addObject:_currentQuestion.answers[0]];
        
        [self.view addSubview:_answerPicker];
        
        //create submit button
        [self createButtonTouchUpInside:self.view.frame.size.width/2-150 :350 :300 :30 :@"Submit"];
        [_buttonsCreated.lastObject addTarget:self action:@selector(submitButtonClickedPickerView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_buttonsCreated.lastObject];
    }
}

-(void)dismissKeyboard
{
    [_textAnswer resignFirstResponder];
}

-(void)submitButtonClickedTextField //used with user data input
{
    if (_textAnswer.text.length>1)
    {
        [_multipleAnswersArray addObject:_textAnswer.text];
        
        //Hide Keyboard
        [_textAnswer resignFirstResponder];
        
        NSMutableArray *tempStorage = [[[NSArray alloc]init]mutableCopy];
        for (int i =0; i<_multipleAnswersArray.count; i++)
        {
            [tempStorage addObject:_multipleAnswersArray[i]];
        }
        
        //Store answer to _answerCollectionArray for future use
        [_multipleAnswersArray addObject:_textAnswer.text];
        [_answerCollectionArray addObject:tempStorage];
       
        //update instance variables
        [self updateInstanceVariables];
       
    }
    else if (_textAnswer.text.length<=1 &&_multipleAnswersArray.count >=1)
    {
        //Hide Keyboard
        [_textAnswer resignFirstResponder];
        
        NSMutableArray *tempStorage = [[[NSMutableArray alloc]init]mutableCopy];
        for (int i =0; i<_multipleAnswersArray.count; i++)
        {
            [tempStorage addObject:_multipleAnswersArray[i]];
        }
        
        //Store answer to _answerCollectionArray for future use
        [_multipleAnswersArray addObject:_textAnswer.text];
        [_answerCollectionArray addObject:tempStorage];
        
        //update instance variables
        [self updateInstanceVariables];

    }
    
    else
    {
        [_textAnswer resignFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Field Required" message:@"Please answer the question in the text field." delegate:nil cancelButtonTitle:(@"OK")otherButtonTitles:nil];
        [alert show];
    }
}

-(void)submitButtonClickedPickerView //used to handle picker view storage
{
    //store answer to _answerCollectionArray
    [_answerCollectionArray addObject:_pickerSelections.lastObject];
    [self updateInstanceVariables];
    
}

-(void)saveProgress
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //save progress
    [userDefaults setInteger:_QPI forKey:@"questionProgressIndex"];
    [userDefaults setObject:_answerCollectionArray forKey:@"userSurveyAnswers"];
     
    [userDefaults synchronize]; //this method saves the userDefault object's values to device
    
    
    
}

-(void)addAnotherTextAnswer
{
    {
        if (_textAnswer.text.length>1)
        {
            //Hide Keyboard
            [_textAnswer resignFirstResponder];
            
            //Store answer to _multipleAnswersArray to embed array into array
            [_multipleAnswersArray addObject:_textAnswer.text];
            
            //reset _textAnswer
            _textAnswer.text=@"";
            _textAnswer.placeholder=@"Press Enter Between Entries";
    
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Field Required" message:@"Please answer the question in the text field." delegate:nil cancelButtonTitle:(@"OK")otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(void)naClicked
{
    if([_textAnswer.text isEqualToString:@""] && _multipleAnswersArray.count == 0)
    {
        [_answerCollectionArray addObject:@"N/A"];
        
        //save and update
        [self updateInstanceVariables];
        //[self saveProgress];
    }
}

-(void)answerClicked:(id) sender
{
    UIButton *answerChosen = sender;
    [_answerCollectionArray addObject:_currentQuestion.answers[answerChosen.tag]];
    
    //update instance variables and save progress
    [self updateInstanceVariables];
}

-(void)updateInstanceVariables
{
    _QPI++;
    
    if (_QPI < _questionsArray.count)
    {
        _currentQuestion = _questionsArray[_QPI];
        
        //save progress
        [self saveProgress];
        
        //remove labels, buttons, and pickers from view
        [self hideLabelsAndButtons];
        
        //prepare next question
        [self setQuestionView];
        
    }
    else //quiz is over initiate exit method
    {
        [self surveyComplete];
    }
}

-(void)surveyComplete
{
    
    [self saveProgress];
    
    //save _answerCollectionArray and update surveyComplete
    [PFUser currentUser] [@"surveyData"] = _answerCollectionArray;
    [PFUser currentUser][@"surveyComplete"]= @YES;
    [[PFUser currentUser] saveEventually];
    
    
    [self hideLabelsAndButtons];
    _currentQuestion=0;
    
    //run algorithm on answers to generate composite score
        //code goes here
    
    //transition to main app
    musicaMatchMainView *controller = [[musicaMatchMainView alloc] init];
    [self.navigationController setViewControllers:@[controller] animated:YES];
}


-(void)createLabel: (int)xAxis :(int) yAxis :(int) width :(int)height :(int)numLines :(NSString*)textOfLabel
{
    UILabel *createLabel = [[UILabel alloc] initWithFrame:CGRectMake(xAxis, yAxis, width, height)];
    createLabel.numberOfLines = numLines;
    createLabel.text = textOfLabel;
    createLabel.textAlignment=NSTextAlignmentCenter;
    createLabel.numberOfLines = numLines;
    [_labelStorage addObject:createLabel];
}

-(void)createButtonTouchUpInside: (int) xAxis :(int) yAxis :(int) width :(int) height :(NSString *) buttonText
{
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [newButton setTitle:buttonText forState:UIControlStateNormal];
    newButton.frame=CGRectMake(xAxis, yAxis, width, height);
    [_buttonsCreated addObject:newButton];
}

- (void)logOut
{
    [PFUser logOut];
    preAuthenticationViewController *signIn = [[preAuthenticationViewController alloc]init];
    [self.navigationController setViewControllers:@[signIn] animated:NO];
}



#pragma mark QuizModel protocol methods

-(void)questionsAreReady
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _QPI = [userDefaults integerForKey:@"questionProgressIndex"];
    _questionsArray=_quizModel.questions;
    _currentQuestion = _questionsArray[_QPI];
    //TODO after quiz completion reset userDefaults _QPI to 0
    
    //remove spinner
    [_spinner removeFromSuperview];
    
    [self setQuestionView];
}


#pragma mark UITextFieldDelegate protocols
-(BOOL)textFieldShouldReturn: (UITextField*)textField
{
    if (_currentQuestion.multipleResponses == [NSNumber numberWithInt:0])
    {
        [self submitButtonClickedTextField];
    }
    else
    {
        [self addAnotherTextAnswer];
    }
    
    return YES;
}

#pragma mark UITextViewDelegate protocols

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
    [self animateButton:_buttonsCreated.lastObject up:YES];
    
    //replace hidden label
    [self createLabel:self.view.frame.size.width/2-150 :201 :300 :120 :0 :_currentQuestion.questionText];
    [self.view addSubview:_labelStorage.lastObject];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
    [self animateButton:_buttonsCreated.lastObject up:NO];
    
    [_labelStorage.lastObject removeFromSuperview];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
    
    
}

-(void)animateButton: (UIButton*) button up:(BOOL)up
{
    const int movementDistance = 100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];

}


#pragma mark UIPickerViewDelegate protocols
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    // Handle the selection
    [_pickerSelections addObject:_currentQuestion.answers[row]];
    
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows = _currentQuestion.answers.count;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    int sectionWidth = 300;
    
    return sectionWidth;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *tView = (UILabel*)view;
    if (!tView)
    {
        // Setup label properties - frame, font, colors etc
        tView = [[UILabel alloc] init];
        //tView.font=[UIFont systemFontOfSize:14];
        tView.adjustsFontSizeToFitWidth=YES;
        tView.textAlignment= NSTextAlignmentCenter;
    }
    // Fill the label text here
   
    NSString *title;
    title =_currentQuestion.answers[row];
    tView.text=title;
    
    return tView;
}

@end
