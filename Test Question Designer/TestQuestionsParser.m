//
//  TestQuestionsParser.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TestQuestionsParser.h"

/**
 C functions
 */
#include <stdio.h> //yay for good old C
NSString *readLineAsNSString(FILE *file)
{
    char buffer[4096];
    
    NSMutableString *result = [NSMutableString stringWithCapacity:256];
    
    // Read up to 4095 non-newline characters, then read and discard the newline
    int charsRead;
    do
    {
        if(fscanf(file, "%4095[^\n]%n%*c", buffer, &charsRead) == 1)
            [result appendFormat:@"%s", buffer];
        else
            break;
    } while(charsRead == 4095);
    
    return result;
}
///end C functions

@implementation TestQuestionsParser

- (NSString*) getTestName
{
    return testName;
}

- (id) initWithFilename:(NSString *)pathToFile
{
    self = [super init];
    if(self)
    {
        questions = [[NSMutableArray alloc] init];
        filePath = pathToFile;
    }
    return self;
}

- (ReadResult) parseQuestions
{
#if DEBUG
    NSLog(@"Opening file: %s", [filePath UTF8String]);
#endif
    
    FILE *file = fopen([filePath UTF8String], "r"); //r for read
    if(file != NULL)
    {
        while(!feof(file)) //read file
        {
            NSString *line = readLineAsNSString(file); //luv u C <3
            if([line hasPrefix:@"TestTitle="])
            {
#if DEBUG
                NSLog(@"Doing test title...");
#endif
                testName = [self readTestTitle:line];
            }
            
            else if([line hasPrefix:@"TrueFalse("])
            {
#if DEBUG
                NSLog(@"Doing truefalse...");
#endif
                TrueFalseQuestion *q = [self readTrueFalseQuestion:line];
                [questions insertObject:q atIndex:0];
            }
            else if([line hasPrefix:@"MultipleChoice("])
            {
#if DEBUG
                NSLog(@"Doing multiple choice...");
#endif
                MultipleChoiceQuestion *q = [self readMultipleChoiceQuestion:line];
                [questions insertObject:q atIndex:0];
                NSLog(@"Count: %ld", [questions count]);
            }
        }
        return ReadingSuccessful;
    }
    else 
    {
        return ReadingFailedCErr;
    }
    return ReadingSuccessful;
}

- (NSString*) readTestTitle:(NSString *)input
{
    //TestTitle="Test Test Test"
    NSRange range = [input rangeOfString:@"="];
#if DEBUG
    NSLog(@"Range location is %ld. Making substring of %ld - %ld", range.location, range.location, input.length - 1);
#endif
    NSString* titlePreTrim = [input substringWithRange:NSMakeRange(range.location + 1, (input.length - range.location - 1))];
    titlePreTrim = [titlePreTrim stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return titlePreTrim;
}

- (MultipleChoiceQuestion *)readMultipleChoiceQuestion:(NSString *)input
{
    NSArray* tokens = [[self trimParameterChars:input] componentsSeparatedByString:@","];
    
    NSMutableArray* answersParsed = [[NSMutableArray alloc] init];
    
    MultipleChoiceQuestion *q = [MultipleChoiceQuestion alloc];
    for(int i = 0; i < [tokens count]; i++)
    {
        if(i == 0) //question
        {
            NSString *questionString = [tokens objectAtIndex:i];
            questionString = [questionString substringWithRange:NSMakeRange(2, (questionString.length - 3))];
            q = [q initWithQuestion:questionString];

        }
        else if(i > 0) //answers
        {
//            NSString *__ans = [self trimQuotes:[tokens objectAtIndex:i]];
            
            NSString *__ans = [tokens objectAtIndex:i];
            __ans = [__ans substringWithRange:NSMakeRange(2, (__ans.length - 3))];
            __ans = [__ans stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            if(i == 1) //first one is always the answer
                [q setAnswerString:__ans];
            
            [answersParsed insertObject:__ans atIndex:0]; //apparently objc will automatically make room for this
        }
    }
    [q setPotentialAnswers:[NSArray arrayWithArray:answersParsed]];
    
    return q;
}

- (TrueFalseQuestion *)readTrueFalseQuestion:(NSString *)input
{
    NSArray* tokens = [[self trimParameterChars:input] componentsSeparatedByString:@","];
    
#if DEBUG
    NSLog(@"Split into tokens");
#endif
    
    TrueFalseQuestion *q = [TrueFalseQuestion alloc];
    for(int i = 0; i < [tokens count]; i++)
    {
        if(i == 0) //question
        {
            NSString *questionString = [NSString stringWithString:[tokens objectAtIndex:i]];
            questionString = [questionString substringWithRange:NSMakeRange(2, (questionString.length - 3))];
            q = [q initWithQuestion:questionString];
        }
        else if(i == 1) //answer
        {
            NSString* trueFalseAnswer = [tokens objectAtIndex:i];
            trueFalseAnswer = [trueFalseAnswer stringByReplacingOccurrencesOfString:@")" withString:@""];
            trueFalseAnswer = [trueFalseAnswer stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSLog(@"lol: %@", [trueFalseAnswer uppercaseString]);
            if([[trueFalseAnswer uppercaseString] isEqualToString:@"TRUE"])
            {
#if DEBUG
                NSLog(@"Answer is true");
#endif
                [q setAnswerAsBool:YES];
                [q setAnswerString:@"true"];
            }
            else {
#if DEBUG
                NSLog(@"Answer is false");
#endif
                [q setAnswerAsBool:NO];
                [q setAnswerString:@"false"];
            }
        }
        else if(i > 1)
            continue;
    }
    [q setQuestionType:FTrueFalse];
    return q;
}

- (NSString*) trimParameterChars:(NSString *)input
{
    //TrueFalse("hey", false);
    NSRange locOfOpenParenthesis = [input rangeOfString:@"("];
#if DEBUG
    NSLog(@"Location of open parenth: %ld", locOfOpenParenthesis.location);
#endif
    NSMutableString *returnValue = [NSMutableString stringWithString:[input substringWithRange:NSMakeRange(locOfOpenParenthesis.location, (input.length - locOfOpenParenthesis.location - 1))]];
    //"hey", false);
    
    if([returnValue characterAtIndex:[returnValue length] - 1] == ')')
    {
//        returnValue = [NSMutableString stringWithString:[returnValue stringByReplacingCharactersInRange:NSMakeRange([returnValue length] - 2, 1) withString:@""]];
        //"hey", false
    }
    return returnValue;
}

- (NSString*) trimQuotes:(NSString *)input
{
    //Assumes quotes are on the beginning and end of the string and just substrings it.
    //Hacky but you know. 
    return [input substringWithRange:NSMakeRange(1, input.length - 1)];
}

- (NSArray*) getParsedQuestions
{
    //NSAssert([questions count] > 0, @"No questions parsed or none in array.");
    return [NSArray arrayWithArray:questions];
}

@end
