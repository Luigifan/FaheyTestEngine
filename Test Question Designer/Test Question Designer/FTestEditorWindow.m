//
//  FTestEditorWindow.m
//  Test Question Designer
//
//  Created by MacBook on 3/22/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FTestEditorWindow.h"
#import "../MultipleChoiceQuestion.h"

/*@inter face FTestEditorWindow ()

@end*/

@implementation FTestEditorWindow
@synthesize testQuestionTableView;
@synthesize mainViewController = mainTableViewController;

- (id)initWithWindowNibNameAndFilePath:(NSString *)nibName :(NSString *)filePath
{
    self = [super initWithWindowNibName:nibName];
    if(self)
    {
        testFilePath = filePath;
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setTitle:@"Test File Editor"];
}

- (void)awakeFromNib
{
    mainTableViewController = [[TableViewController alloc] init];
    if(testFilePath != nil)
    {
        [self.window setRepresentedFilename:testFilePath];
        [self.window setDocumentEdited:NO];
        questionsParser = [[TestQuestionsParser alloc] initWithFilename:testFilePath];
        ReadResult result = [questionsParser parseQuestions];
        if(result == ReadingSuccessful)
        {
            NSLog(@"Read ok!");
            [self addQuestionsIntoDataSource];
        }
        else {
            NSLog(@"Read failed! %@", result);
        }
    }
    [testQuestionTableView setDataSource:mainTableViewController];
}

- (void)addQuestionsIntoDataSource
{
    NSArray* questionsArray = [questionsParser getParsedQuestions];
    for(int i = 0; i < [questionsArray count]; i++)
    {
        FQuestion* question = [questionsArray objectAtIndex:i];
        NSLog(@"Question: %@", [question questionString]);
        if([question questionString] != nil)
            [mainTableViewController insertString:[NSString stringWithString:[question questionString]]];
    }
}

-(BOOL) saveTestQuestions
{
//    NSMutableString* theFile = [NSMutableString stringWithString:@""];
    for(int i = 0; i < [questionsParser getParsedQuestions].count; i++)
    {
        FQuestion* question = [[questionsParser getParsedQuestions] objectAtIndex:i];
        switch(question.questionType)
        {
            case FMultipleChoice:
                
                break;
            case FTrueFalse:
                break;
            default:
                //Don't write
                break;
        }
    }
    return true;
}

@end
