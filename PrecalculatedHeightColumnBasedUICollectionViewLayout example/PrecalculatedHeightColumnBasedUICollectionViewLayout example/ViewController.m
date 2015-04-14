//
//  ViewController.m
//  PrecalculatedHeightColumnBasedUICollectionViewLayout example
//
//  Created by J C Ospina Gonzalez on 14-04-15.
//

#import "ViewController.h"
#import "DummyObject.h"
#import "CustomCollectionViewCell.h"
#import "PrecalculatedHeightColumnBasedUICollectionViewLayout.h"

@interface ViewController ()

@end

@implementation ViewController

static NSString *identifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup a model
    numberColumns = 5;
    int maxNumberRows = 50;
    int maxHeight = 500;
    int minHeight = 50;
    
    content = [NSMutableArray array];
    for (int i = 0; i < numberColumns; i++) {
        NSMutableArray *column = [NSMutableArray array];
        int num = arc4random() % maxNumberRows;
        while (num > 0) {
            DummyObject *ob = [[DummyObject alloc] init];
            ob.precalculatedHeight = (arc4random() % (maxHeight - minHeight)) + minHeight;
            [column addObject:ob];
            num--;
        }
        [content addObject:column];
    }
    
    NSLog(@"content %@",content);
    
    PrecalculatedHeightColumnBasedUICollectionViewLayout *customLayout = [[PrecalculatedHeightColumnBasedUICollectionViewLayout alloc] init];
    customLayout.horizontalScrollEnabled = NO;
    customLayout.columnWidth = 250.0;
    customLayout.dataSource = self;

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = customLayout;
    [self.collectionView reloadData];
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *arr = (NSMutableArray *)[content objectAtIndex:section];
    return arr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *arr = (NSMutableArray *)[content objectAtIndex:indexPath.section];
    DummyObject *ob = [arr objectAtIndex:indexPath.row];
    
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // show dimensions
    cell.titleLabel.text = [NSString stringWithFormat:@"250 x %i",(int)ob.precalculatedHeight];
    
    // for kicks and giggles!
    int red = arc4random() % 255;
    int green = arc4random() % 255;
    int blue = arc4random() % 255;
    cell.backgroundColor = [UIColor colorWithRed:red / 255.0 green:green/ 255.0 blue:blue/ 255.0 alpha:1.0];
    return cell;
}

#pragma -mark PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource

-(id <PrecalculatedHeightObject>)objectForColumn:(int)column position:(int)position{
    if([content objectAtIndex:column] != nil){
        NSArray *columnArr = [content objectAtIndex:column];
        if (columnArr.count > position) {
            return [columnArr objectAtIndex:position];
        }
    }
    return nil;
}

-(int)numberObjectsInColumn:(int)column{
    if([content objectAtIndex:column] != nil){
        NSArray *columnArr = [content objectAtIndex:column];
        return columnArr.count;
    }
    return -1;
}

-(int)numberColumns{
    return numberColumns;
}
@end
