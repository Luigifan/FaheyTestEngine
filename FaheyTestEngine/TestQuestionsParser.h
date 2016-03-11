//
//  TestQuestionsParser.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Question.h"
#import "MultipleChoiceQuestion.h"
#import "TrueFalseQuestion.h"

@interface TestQuestionsParser : NSObject{
    NSMutableArray* questions; //array of FQuestion objects
    NSString* testName;
    NSString* filePath;
}
enum {
    ReadingFailedCErr = -2, //An error occurred in stdio
        ReadingFailed = -1, //General error
    ReadingSuccessful = 0 //Reading was fine
};
typedef NSInteger ReadResult; //returned by the read function

- (id) initWithFilename: (NSString*)pathToFile; //constructor

- (ReadResult) parseQuestions;
- (NSString*) readTestTitle: (NSString*)input;
- (MultipleChoiceQuestion*)readMultipleChoiceQuestion: (NSString*)input;
- (TrueFalseQuestion*)readTrueFalseQuestion: (NSString*)input;

- (NSString*) trimParameterChars: (NSString*)input;
- (NSString*) trimQuotes: (NSString*)input;

- (NSString*) getTestName;

- (NSArray*)getParsedQuestions; //returns the mutable array as a non-mutable array
@end
