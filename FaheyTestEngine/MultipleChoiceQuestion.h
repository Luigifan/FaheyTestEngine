//
//  MultipleChoiceQuestion.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface MultipleChoiceQuestion : FQuestion

- (id) initWithAnswers: (NSArray*)answers;

@property NSArray* potentialAnswers;
@end
