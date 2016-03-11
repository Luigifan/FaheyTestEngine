//
//  TrueFalseQuestion.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface TrueFalseQuestion : FQuestion

- (id) initWithBoolAnswer: (BOOL)ans;

@property BOOL answerAsBool;
@end
