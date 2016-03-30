#import <Foundation/Foundation.h>
@interface TableViewController : NSObject<NSTableViewDataSource> {
@private
    IBOutlet NSTableView* tableView;
    NSMutableArray *listOfObjects;
}

- (IBAction)addObject:(id)sender;
- (void)insertString:(NSString*)string;

@end