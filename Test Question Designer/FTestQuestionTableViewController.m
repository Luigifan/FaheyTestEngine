#import "FTestQuestionTableViewController.h"

@implementation TableViewController

- (id) init
{
    self = [super init];
    if(self)
    {
        listOfObjects = [[NSMutableArray alloc] init];
        [self addObject:self];
    }
    
    return self;
}

- (IBAction) addObject:(id)sender
{
    [listOfObjects addObject:sender];
}

- (void) insertString:(NSString *)string
{
    [listOfObjects addObject:string];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    return [listOfObjects count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [listOfObjects objectAtIndex:row];
}

@end