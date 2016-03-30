//
//  Question.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Question.h"

/**
 Partial implementation as other classes are supposed to extend this
 */
@implementation FQuestion

@synthesize questionType = _questionType;
@synthesize questionString = _questionString;
@synthesize answerString = _answerString;

- (id) init
{
    self = [super init];
    if(self) {
        _questionType = FUNDEFINEDQUESTION;
    }
    return self;
}

- (id) initWithQuestion: (NSString*)q
{
    self = [super init];
    if (self) 
    {
        _questionType = FUNDEFINEDQUESTION;
        _questionString = q;
    }
    return self;
}

- (id) initWithQuestionAndAnswer:(NSString *)q :(NSString *)a
{
    self = [super init];
    if(self)
    {
        _questionType = FUNDEFINEDQUESTION;
        _questionString = q;
        _answerString = a;
    }
    return self;
}

@end
