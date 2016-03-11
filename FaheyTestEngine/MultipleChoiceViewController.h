//
//  MultipleChoiceViewController.h
//  FaheyTestEngine
//
//  Created by MacBook on 3/9/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MultipleChoiceQuestion;
@interface MultipleChoiceViewController : NSViewController{
    MultipleChoiceQuestion* theQuestion;
}

- (id) initWithNibNameAndQuestion:(NSString*)nibName:(MultipleChoiceQuestion*)question;
- (void) createMatrixGroupOutofQuestionAnswers:(NSArray *)answers;
@property (weak) IBOutlet NSTextField *questionTextField;

@end
