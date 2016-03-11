//
//  SettingsStorage.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/28/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsStorage : NSObject <NSCoding>

@property NSMutableArray* availableTestFiles;
@property NSString* lastSelectedTest;
@end
