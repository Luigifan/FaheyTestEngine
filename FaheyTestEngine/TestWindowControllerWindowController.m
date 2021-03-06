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
#import "TrueFalseViewController.h"
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
    {
        currentQuestionIndex = 0;
        [self.window setTitle:@"Finished test!"];
    }
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
        multipleChoiceQuestionViewController = [[MultipleChoiceViewController alloc] initWithNibNameAndQuestion:@"MultipleChoiceViewController" :question];
        
        NSView* contentView = self.window.contentView;
    
        [(NSView*)multipleChoiceQuestionViewController.view setFrame:[contentView bounds]];
        [(NSView*)multipleChoiceQuestionViewController.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        //[multipleChoiceQuestionViewDelegate.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [multipleChoiceQuestionViewController.view setAutoresizesSubviews:YES];
    
        [self.window.contentView addSubview:multipleChoiceQuestionViewController.view];
        NSLog(@"Added multiplechoice subview");
    }
    else if(questionToInsert.questionType == FTrueFalse)
    {
        TrueFalseQuestion* question = (TrueFalseQuestion*)questionToInsert;
        
        trueFalseQuestionViewController = [[TrueFalseViewController alloc] initWithNibNameAndQuestion:@"TrueFalseViewController" :question];
        
        NSView* contentView = self.window.contentView;
        [(NSView*)trueFalseQuestionViewController.view setFrame:[contentView bounds]];
        [(NSView*)trueFalseQuestionViewController.view setAutoresizesSubviews:NSViewHeightSizable | NSViewWidthSizable];
        [trueFalseQuestionViewController.view setAutoresizesSubviews:YES];
        
        [self.window.contentView addSubview:trueFalseQuestionViewController.view];
        NSLog(@"Added t/f subview");
    }
}

/**
 Unused
 */
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
        currentQuestionIndex = 0;
        [self putQuestionInWindow];
    }
    else
    {
        //TODO: error message and exiting window
    }
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
