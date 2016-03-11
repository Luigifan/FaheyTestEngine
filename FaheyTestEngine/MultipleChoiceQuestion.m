//
//  MultipleChoiceQuestion.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MultipleChoiceQuestion.h"

@implementation MultipleChoiceQuestion
//base class synthesizes
@synthesize questionType = _questionType;
@synthesize questionString = _questionString;
@synthesize answerString = _answerString;
//
@synthesize potentialAnswers = _potentialAnswers;

- (id) init
{
    self = [super init];
    if(self) {
        _questionType = FMultipleChoice;
    }
    return self;
}

- (id) initWithQuestion: (NSString*)q
{
    self = [super init];
    if (self) 
    {
        _questionType = FMultipleChoice;
        _questionString = q;
    }
    return self;
}

- (id) initWithQuestionAndAnswer:(NSString *)q :(NSString *)a
{
    self = [super init];
    if(self)
    {
        _questionType = FMultipleChoice;
        _questionString = q;
        _answerString = a;
    }
    return self;
}


- (id)initWithAnswers:(NSArray *)answers
{
    self = [super init];
    if (self) {
        _questionType = FMultipleChoice;
        _potentialAnswers = [NSArray arrayWithArray:answers]; //copies
    }
    return self;
}

@end
