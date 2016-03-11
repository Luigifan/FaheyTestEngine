//
//  TrueFalseViewController.m
//  FaheyTestEngine
//
//  Created by MacBook on 3/9/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TrueFalseViewController.h"

@interface TrueFalseViewController ()

@end

@implementation TrueFalseViewController
@synthesize questionLabel;

- (id)initWithNibNameAndQuestion:(NSString *)nibName :(TrueFalseQuestion *)question
{
    self = [super initWithNibName:nibName bundle:nil];
    if(self)
    {
        theQuestion = question;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
