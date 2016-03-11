//
//  ScottTableViewController.h
//  TABLEVIEWTEST
//
//  Created by MacBook on 3/1/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewController : NSObject <NSTableViewDataSource>

- (id) initWithArrays: (NSMutableArray*)firstColumnArray: (NSMutableArray*)secondColumnArray;
- (void) insertRow: (NSString*)firstColumn: (NSString*)secondColumn;
@property (nonatomic, strong) NSMutableArray* column1;
@property (nonatomic, strong) NSMutableArray* column2;

@end
