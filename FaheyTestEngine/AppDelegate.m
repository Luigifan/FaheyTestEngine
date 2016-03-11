//
//  AppDelegate.m
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "TestQuestionsParser.h"
#import "Question.h"
#import "TestWindowControllerWindowController.h"

@implementation AppDelegate

NSString* const keyAvailableTestsColumn1 = @"fAvailableTests1";
NSString* const keyAvailableTestsColumn2 = @"fAvailableTests2";
NSString* const keyLastSelectedTest = @"fLastSelectedTest";

@synthesize window = _window;
@synthesize availableTestsTable = _availableTestsTable;
@synthesize MainLabel = _MainLabel;
@synthesize userDefaults = _userDefaults;
@synthesize mainTableViewController = _mainTableViewController;
@synthesize defaultsAvailableTestsColumn1 = _defaultsAvailableTestsColumn1;
@synthesize defaultsAvailableTestsColumn2 = _defaultsAvailableTestsColumn2;
@synthesize lastSelectedTest = _defaultsLastSelectedTest;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (id) init
{
    self = [super init];
    if(self)
    {
        _defaultsAvailableTestsColumn1 = [[NSMutableArray alloc] init];
        _defaultsAvailableTestsColumn2 = [[NSMutableArray alloc] init];
        _defaultsLastSelectedTest= @"N/A :D";
    }
    return self;
}

- (void) awakeFromNib
{
    //Init and set in same statement
    //NSMutableArray* array1 = [[NSMutableArray alloc] initWithObjects:@"Kek", @"Top", nil];
    //NSMutableArray* array2 = [[NSMutableArray alloc] initWithObjects:@"Lol", @"High", nil];
    //_mainTableViewController = [[TableViewController alloc] initWithArrays:array1 :array2];
    _mainTableViewController = [[TableViewController alloc] init];
    
    [_availableTestsTable setDataSource:_mainTableViewController];
    [_availableTestsTable reloadData];
    
    [NSApp setDelegate:self];
    [self loadSettingsFromDisk];
    
    [_availableTestsTable setDelegate:self];
    [_availableTestsTable setDoubleAction:@selector(tableDoubleClickAction:)];
}

- (void) tableDoubleClickAction:(id)nib
{
    NSInteger rowNumber = [_availableTestsTable clickedRow]; //row
    if(rowNumber >= 0)
    {
        NSString* path = [[_mainTableViewController column2] objectAtIndex:rowNumber];
        if(!testWindowController)
        {
            testWindowController = [[TestWindowControllerWindowController alloc] initWithWindowNibNameAndTestPath:@"TestWindowControllerWindowController" :path];
        }
        [testWindowController showWindow:nil];
        //TODO: figure out multiple windows lol
    }
}

- (void) applicationWillTerminate:(NSNotification *)notification
{
    [self writeSettingsToDisk];
}

- (void) loadSettingsFromDisk
{
    //register defaults on every launch
    NSDictionary* defaultsPointer = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:_defaultsAvailableTestsColumn1, _defaultsAvailableTestsColumn2, _defaultsLastSelectedTest, nil] forKeys:[NSArray arrayWithObjects:keyAvailableTestsColumn1, keyAvailableTestsColumn2, keyLastSelectedTest, nil]];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsPointer];
    NSLog(@"Last Test: %@", [[NSUserDefaults standardUserDefaults] stringForKey:keyLastSelectedTest]);
    [self postLoadInit];
}

- (void) postLoadInit
{
    //Just a test as of right now to see if it worked 
    //NSArray* f = [[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTests];
    //TODO: load
    NSMutableArray* column1 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTestsColumn1]];
    NSMutableArray* column2 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTestsColumn2]];
    _mainTableViewController = [[TableViewController alloc] initWithArrays:column1 :column2];
    [_availableTestsTable setDataSource:_mainTableViewController];
    [_availableTestsTable reloadData];
}

- (void) writeSettingsToDisk
{
    NSLog(@"Writing defaults..");
    
    NSMutableArray* column1 = [_mainTableViewController column1];
    NSMutableArray* column2 = [_mainTableViewController column2];
    [[NSUserDefaults standardUserDefaults] setObject:column1 forKey:keyAvailableTestsColumn1];
    [[NSUserDefaults standardUserDefaults] setObject:column2 forKey:keyAvailableTestsColumn2];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"N/A :D" forKey:keyLastSelectedTest];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) readTestIntoLabel:(TestQuestionsParser *)parser
{}

- (IBAction)openTestClicked:(id)sender 
{
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    [openPanel setTitle:@"Open MTS File for Test Reading"];
    [openPanel setAllowedFileTypes:[NSArray arrayWithObject:@"mts"]];
    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
        if(result == NSOKButton)
        {
            NSLog(@"Got ok from open panel");
            NSLog(@"URL Path: %@", [[openPanel URL]path]);
            TestQuestionsParser *parser = [[TestQuestionsParser alloc] initWithFilename:[[openPanel URL] path]];
            //[[TestQuestionsParser alloc] initWithFilename:[[openPanel URL] absoluteString]];
            	
            ReadResult result = [parser parseQuestions];
            if(result == ReadingSuccessful )
            {
                NSLog(@"Parser ok");
                [self parserOkaySoPutTestIntoArray:parser :[[openPanel URL] path]];
                ///NSMutableArray* f = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTests]];
//                [f insertObject:[[openPanel URL] path] atIndex:0];
                
                //[[_mainSettings availableTestFiles] insertObject:[[openPanel URL] path] atIndex:0];
                //[_availableTestsTable setDataSource:[NSArray arrayWithArray:[_mainSettings availableTestFiles]]];
                //[_availableTestsTable reloadData];
                NSLog(@"Reloaded!");
            }
            else {
                NSLog(@"Parser error with code %ld", result);
            }
        }
    }];
}

//Finally getting some Objective C style method names!!
- (void) parserOkaySoPutTestIntoArray:(TestQuestionsParser *)parser: (NSString*) path
{
    //column 1 is the test name
    NSMutableArray* column1 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTestsColumn1]];
    //column 2 is the test file path
    NSMutableArray* column2 = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keyAvailableTestsColumn1]];
    
    [column1 insertObject:[parser getTestName] atIndex:0];
    [column2 insertObject:path atIndex:0];
    
    _mainTableViewController = [[TableViewController alloc] initWithArrays:column1 :column2];
    [_availableTestsTable setDataSource:_mainTableViewController];
    [_availableTestsTable reloadData];
}

- (NSString*) getSettingsLocationPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *folder = @"~/Library/Application Support/FaheyTestEngine/";
    folder = [folder stringByExpandingTildeInPath];
    
    if([manager fileExistsAtPath:folder] == NO)
    {
        [manager createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *filename = @"Settings.settings";
    return [folder stringByAppendingPathComponent:filename];
}

@end
