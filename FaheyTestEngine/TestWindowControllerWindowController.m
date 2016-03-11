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
            break;
        default:
            break;
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
            }
        }
        
        if(question)
        {
            //yeet
            multipleChoiceQuestionViewDelegate = [[MultipleChoiceViewController alloc] initWithNibNameAndQuestion:@"MultipleChoiceViewController" :question];
            [(NSView*)multipleChoiceQuestionViewDelegate.view setFrame:[self.window.contentView bounds]];
            [(NSView*)multipleChoiceQuestionViewDelegate.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
            //[multipleChoiceQuestionViewDelegate.view setAutoresizesSubviews:YES];
            
            [self.window.contentView addSubview:multipleChoiceQuestionViewDelegate.view];
            NSLog(@"Added subview");
        }
    }
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
