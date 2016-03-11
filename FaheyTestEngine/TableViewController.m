//
//  ScottTableViewController.m
//  TABLEVIEWTEST
//
//  Created by MacBook on 3/1/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import <Cocoa/Cocoa.h>

@implementation TableViewController

@synthesize column1 = _numbers;
@synthesize column2 = _numberCodes;

- (id) init
{
    self = [super init];
    if(self)
    {
        //self.numbers = self.numbers;
        //self.numberCodes = self.numberCodes;
    }
    return self;
}

- (id) initWithArrays: (NSMutableArray*)firstColumnArray: (NSMutableArray*)secondColumnArray
{
    self = [super init];
    if(self)
    {
        self.column1 = firstColumnArray;
        self.column2 = secondColumnArray;
    }
    return self;
}

- (void) insertRow:(NSString *)firstColumn :(NSString *)secondColumn
{
    [self.column1 insertObject:firstColumn atIndex:0];
    [self.column2 insertObject:secondColumn atIndex:0];
}

- (NSMutableArray*) column1
{
    if(!_numbers)
    {
        _numbers = [[NSMutableArray alloc] init];
    }
    return _numbers;
}

- (NSMutableArray*) column2
{
    if(!_numberCodes)
    {
        _numberCodes = [[NSMutableArray alloc] init];
    }
    return _numberCodes;
}

#pragma mark Table View Controller Exclusive Stuffs

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.column1.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if([[tableColumn identifier] isEqualToString:@"column1"])
    {
        return [self.column1 objectAtIndex:row];
    }
    else if([[tableColumn identifier] isEqualToString:@"column2"])
    {
        return [self.column2 objectAtIndex:row];
    }
    return nil;
}
@end
