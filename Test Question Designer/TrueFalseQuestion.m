//
//  TrueFalseQuestion.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TrueFalseQuestion.h"

@implementation TrueFalseQuestion
//base class synthesizes
@synthesize questionType = _questionType;
@synthesize questionString = _questionString;
@synthesize answerString = _answerString;
//
@synthesize answerAsBool = _answerAsBool;

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

- (id) initWithBoolAnswer:(BOOL)ans
{
    self = [super init];
    if(self)
    {
        _questionType = FTrueFalse;
        _answerAsBool = ans;
        if(ans)
            _answerString = @"true";
        else
            _answerString = @"false";
    }
    return self;
}
@end
