//
//  MultipleChoiceViewController.m
//  FaheyTestEngine
//
//  Created by MacBook on 3/9/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "MultipleChoiceQuestion.h"
#import <QuartzCore/QuartzCore.h>

@interface MultipleChoiceViewController ()

@end

@implementation MultipleChoiceViewController
@synthesize questionTextField;

- (id)initWithNibNameAndQuestion:(NSString *)nibName :(MultipleChoiceQuestion *)question
{
    self = [super initWithNibName:nibName bundle:nil];
    if(self)
    {
        theQuestion = question;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    
    return self;
}

- (void)createMatrixGroupOutofQuestionAnswers:(NSArray *)answers
{
    NSLog(@"(MultipleChoiceViewController): Need to make %ld buttons.", [answers count]);
    
    NSButtonCell* proto = [[NSButtonCell alloc] init];
    //Temporary workaround because apparently you can't resize NSButtonCells :/
    [proto setTitle:@"fffffjsdifjaoweijfaosdjfoaijsfoiajeoofiasjdfoijasdoifjoaisdjfoiajsdofiajsodifjaoisdjfifjaoeiwjfaoisdjfoij"];
    [proto setButtonType:NSRadioButton]; //yeet, prototyping
    
    NSRect matrixRect = NSMakeRect(12, 145, 300, 70); //TODO: properly define spacing
    
    
    NSMatrix* matrix = [[NSMatrix alloc] initWithFrame:matrixRect mode:NSRadioModeMatrix prototype:(NSCell*)proto numberOfRows:[answers count] numberOfColumns:1];
    [matrix setHidden:NO];
    [matrix setAutoresizesSubviews:YES];
    [matrix setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    NSArray* cells = [matrix cells];
    for(int i = 0; i < [cells count]; i++)
    {
        NSButtonCell* cell = [cells objectAtIndex:i];
        [cell setTitle:(NSString*)[answers objectAtIndex:i]];
    }
    [self.view addSubview:matrix];
    NSLog(@"Added subview");
}

-(void)awakeFromNib
{    
    if(theQuestion)
    {
        NSLog(@"(View Controller) Question String: %@", [theQuestion questionString]); 
        [questionTextField setStringValue:[theQuestion questionString]];
        [self createMatrixGroupOutofQuestionAnswers:[theQuestion potentialAnswers]];
    }
    else 
    {
        NSLog(@"(View Controller) Question nil!");
    }
}
@end
