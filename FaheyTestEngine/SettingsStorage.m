//
//  SettingsStorage.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/28/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SettingsStorage.h"

@implementation SettingsStorage
@synthesize availableTestFiles = _availableTestFiles;
@synthesize lastSelectedTest = _lastSelectedTest;

- (id) init 
{
    self = [super init];
    if(self)
    {
        [self setAvailableTestFiles:[[NSMutableArray alloc] init]];
        [_availableTestFiles insertObject:@"test" atIndex:0];
        [self setLastSelectedTest:nil];
    }
    return self;
}

- (id) initWithCoder: (NSCoder*)coder
{
    self = [super init];
    if(self)
    {
        [self setAvailableTestFiles:[coder decodeObjectForKey:@"availableTestFiles"]];
        [self setLastSelectedTest:[coder decodeObjectForKey:@"lastSelectedTest"]];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder*)coder
{
    [coder encodeObject:[NSArray arrayWithArray:_availableTestFiles] forKey:@"availableTestFiles"];
    [coder encodeObject:_lastSelectedTest forKey:@"lastSelectedTest"];
}

@end
