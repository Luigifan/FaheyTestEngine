//
//  TestWindowControllerWindowController.m
//  FaheyTestEngine
//
//  Created by MacBook on 3/8/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TestWindowControllerWindowController.h"
#import "TestQuestionsParser.h"
#import "MultipleChoiceViewController.h"
#import "Question.h"

#import <stdlib.h>

@interface TestWindowControllerWindowController ()
@end

@implementation TestWindowControllerWindowController
@synthesize segmentedCellToolbarItem;
@synthesize endToolbarItem;
@synthesize nextToolbarItem;
@synthesize resetToolbarItem;
@synthesize previousToolbarItem;
@synthesize testOrder;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithWindowNibNameAndTestPath:(NSString *)windowName :(NSString *)path
{
    self = [super initWithWindowNibName:windowName];
    if(self)
    {
        testPath = path;
        testOrder = [NSMutableArray array]; //yeet
    }
    return self;
}

- (IBAction)endToolbarItemClicked:(id)sender 
{
    [self close];
    //TODO: proper test quitting
}

- (IBAction)segmentedControlSegmentClicked:(id)sender 
{
    switch([segmentedCellToolbarItem selectedSegment])
    {
        case 0: //previous
            NSLog(@"Previous question button clicked.");
            break;
        case 1: //reset
            NSLog(@"Reset question button clicked.");
            break;
        case 2: //next
            NSLog(@"Next question button clicked.");
            [self goToNextQuestion];
            [self removeCurrentQuestionView];
            [self putQuestionInWindow];
            break;
        default:
            break;
    }
}

- (void) goToNextQuestion
{
    currentQuestionIndex++;
    if(currentQuestionIndex > [[testQuestionParser getParsedQuestions] count] - 1)
        currentQuestionIndex = 0;
    //TODO: completed test
}

- (void) goToPreviousQuestion
{
    currentQuestionIndex--;
    if(currentQuestionIndex < 0)
        currentQuestionIndex = 0;
    //TODO: play error sound and stuff.
}

/**
 JK, removes all subviews/
 */
- (void) removeCurrentQuestionView
{
    for(NSView* view in [self.window.contentView subviews])
    {
        [view removeFromSuperview];
    }
}

/**
 Takes from self.currentQuestionIndex
 */
- (void) putQuestionInWindow
{
    FQuestion* questionToInsert = [[testQuestionParser getParsedQuestions] objectAtIndex:currentQuestionIndex];
    if(questionToInsert.questionType == FMultipleChoice)
    {
        MultipleChoiceQuestion* question = (MultipleChoiceQuestion*)questionToInsert;
        //yeet
        multipleChoiceQuestionViewDelegate = [[MultipleChoiceViewController alloc] initWithNibNameAndQuestion:@"MultipleChoiceViewController" :question];
        
        NSView* contentView = self.window.contentView;
    
        [(NSView*)multipleChoiceQuestionViewDelegate.view setFrame:[contentView bounds]];
        [(NSView*)multipleChoiceQuestionViewDelegate.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        //[multipleChoiceQuestionViewDelegate.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [multipleChoiceQuestionViewDelegate.view setAutoresizesSubviews:YES];
    
        [self.window.contentView addSubview:multipleChoiceQuestionViewDelegate.view];
        NSLog(@"Added subview");
    }
    else if(questionToInsert.questionType == FTrueFalse)
    {
        TrueFalseQuestion* question = (TrueFalseQuestion*)questionToInsert;
    }
}

- (void)generateTestOrder
{
    NSInteger questionIndex = arc4random_uniform(([[testQuestionParser getParsedQuestions] count] + 1));
    NSNumber* yeet = [NSNumber numberWithInt:questionIndex];
    if(![testOrder containsObject:yeet])
    {
        [testOrder insertObject:yeet atIndex:[testOrder count] - 1]; //yeet
    }
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSSize sizeStruct;
    sizeStruct.width = 500.0f;
    sizeStruct.height = 420.0f;
    [self.window setMinSize:sizeStruct];
    
    NSRect frame = self.window.frame;
    frame.size = sizeStruct;
    [self.window setFrame:frame display:YES animate:YES];
    
    [self.window.contentView setAutoresizesSubviews:YES];
#if DEBUG
    //don't fullscreen during debug mode. why would you do that????
#else
    [self.window toggleFullScreen:nil];
#endif
    
    if(!testQuestionParser && testPath){
        testQuestionParser = [[TestQuestionsParser alloc] initWithFilename:testPath];
    }
    
    ReadResult res = [testQuestionParser parseQuestions];
    if(res == ReadingSuccessful)
    {
        MultipleChoiceQuestion* question;
        NSArray* questions = [testQuestionParser getParsedQuestions];
        for(int i = 0; i < [questions count]; i++)
        {
            FQuestion* _____q = [questions objectAtIndex:i];
            if([_____q questionType] == FMultipleChoice)
            {
                question = (MultipleChoiceQuestion*)_____q;
                currentQuestionIndex = i;
            }
        }
        
        if(question)
        {
            
            //yeet
            multipleChoiceQuestionViewDelegate = [[MultipleChoiceViewController alloc] initWithNibNameAndQuestion:@"MultipleChoiceViewController" :question];
            
            NSView* contentView = self.window.contentView;
            
            [(NSView*)multipleChoiceQuestionViewDelegate.view setFrame:[contentView bounds]];
            [(NSView*)multipleChoiceQuestionViewDelegate.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
            //[multipleChoiceQuestionViewDelegate.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [multipleChoiceQuestionViewDelegate.view setAutoresizesSubviews:YES];
            
            [self.window.contentView addSubview:multipleChoiceQuestionViewDelegate.view];
            NSLog(@"Added subview");
        }
    }
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
