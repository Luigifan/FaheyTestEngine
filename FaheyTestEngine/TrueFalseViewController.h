//
//  TrueFalseViewController.h
//  FaheyTestEngine
//
//  Created by MacBook on 3/9/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TrueFalseQuestion;
@interface TrueFalseViewController : NSViewController {
    TrueFalseQuestion* theQuestion;
}

- (id) initWithNibNameAndQuestion:(NSString*)nibName:(TrueFalseQuestion*)question;
@property (weak) IBOutlet NSTextField *questionLabel;
@end
