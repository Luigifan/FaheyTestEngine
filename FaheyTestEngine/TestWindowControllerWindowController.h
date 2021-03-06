//
//  TestWindowControllerWindowController.h
//  FaheyTestEngine
//
//  Created by MacBook on 3/8/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 Forward Declarations
 */
@class TestQuestionsParser;
@class MultipleChoiceViewController; //declare a single, reusable multiple choice question view for use
@class TrueFalseViewController;
@class FQuestion;
//

@interface TestWindowControllerWindowController : NSWindowController <NSWindowDelegate>{
    NSString* testPath;
    TestQuestionsParser* testQuestionParser;
    MultipleChoiceViewController* multipleChoiceQuestionViewController;
    TrueFalseViewController* trueFalseQuestionViewController;
    
    int currentQuestionIndex;
}

- (void) generateTestOrder;

- (void) goToNextQuestion;
- (void) goToPreviousQuestion;
- (void) putQuestionInWindow;
- (void) removeCurrentQuestionView;

//stores the indexes we've done already so we don't accidentally pick them
@property NSMutableArray* testOrder;

@property (weak) IBOutlet NSSegmentedCell *segmentedCellToolbarItem;
@property (weak) IBOutlet NSToolbarItem *endToolbarItem;
@property (weak) IBOutlet NSToolbarItem *nextToolbarItem;
@property (weak) IBOutlet NSToolbarItem *resetToolbarItem;
@property (weak) IBOutlet NSToolbarItem *previousToolbarItem;

@property (weak) IBOutlet NSNumber* trueRadioButton;
@property (weak) IBOutlet NSNumber* falseRadioButton;

- (id) initWithWindowNibNameAndTestPath: (NSString*)windowName: (NSString*)path;
@end
