//
//  Question.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FQuestion : NSObject
/**
 Contains the enum definition for various question types.
 */
typedef enum {
    FUNDEFINEDQUESTION = -1,
    FMultipleChoice = 0,
    FTrueFalse = 1
} FQuestionType;

- (id) initWithQuestion: (NSString*)q;
- (id) initWithQuestionAndAnswer: (NSString*) q : (NSString*)a;

@property NSString* questionString;
@property NSString* answerString;
@property FQuestionType questionType;
@end
