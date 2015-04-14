//
//  PrecalculatedHeightColumnBasedUICollectionViewLayout.m
//
//  Created by J C Ospina Gonzalez on 09-04-15.
//

#import "PrecalculatedHeightColumnBasedUICollectionViewLayout.h"
#import "PrecalculatedHeightObject.h"

@implementation PrecalculatedHeightColumnBasedUICollectionViewLayout
@synthesize dataSource,columnWidth,columnSpacing, rowSpacing, horizontalScrollEnabled, verticalScrollEnabled;

-(id)init{
    self = [super init];
    if(self){
        // default values
        columnWidth = 234.0;
        columnSpacing = 4.0;
        rowSpacing = 4.0;
        precalculatedContentSize = CGSizeZero;
        horizontalScrollEnabled = YES;
        verticalScrollEnabled = YES;
    }
    return self;
}

-(CGSize)collectionViewContentSize{
    CGSize finalSize = self.collectionView.bounds.size;
    if(horizontalScrollEnabled){
        finalSize.width = precalculatedContentSize.width;
    }
    if(verticalScrollEnabled){
        finalSize.height = precalculatedContentSize.height;
    }
    return finalSize;
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

-(void)prepareLayout{
    [super prepareLayout];

    if(self.dataSource != nil){
        
        // reset the hights column height precalculation
        float precalculatedHighestColumnHeight = 0.0;
        
        float xpos = 0.0;
        NSMutableArray *tempColumnRects = [NSMutableArray array];
        NSMutableArray *tempObjectRects = [NSMutableArray array];
        
        // loop columns
        int columns = [self.dataSource numberColumns];
        for (int i = 0; i < columns; i++) {
            
            // loop inside column
            int numItems = [self.dataSource numberObjectsInColumn:i];
            float thisColumnHeight = 0.0;
            
            // Array of rectangles for column
            NSMutableArray *tempObjectRectsThisColumn = [NSMutableArray array];
            
            for (int j = 0; j < numItems; j++) {

                id<PrecalculatedHeightObject> ob = [self.dataSource objectForColumn:i position:j];
                
                if(ob != nil){
                    CGRect objectRect = CGRectMake(xpos, thisColumnHeight, columnWidth, ob.precalculatedHeight);
                    [tempObjectRectsThisColumn addObject:[NSValue valueWithCGRect:objectRect]];
                    thisColumnHeight += ob.precalculatedHeight;
                    thisColumnHeight += rowSpacing;
                }
            }
            
            //add column rect
            CGRect rectForColumn = CGRectMake(xpos, 0.0, columnWidth, thisColumnHeight);
            [tempColumnRects addObject:[NSValue valueWithCGRect:rectForColumn]];
            
            //add objects rects
            [tempObjectRects addObject:[NSArray arrayWithArray:tempObjectRectsThisColumn]];
            
            xpos += columnWidth + columnSpacing;
            
            if (thisColumnHeight > precalculatedHighestColumnHeight) {
                precalculatedHighestColumnHeight = thisColumnHeight;
            }
        }
        
        // store final values
        precalculatedRectanglesColumns = [NSArray arrayWithArray:tempColumnRects];
        precalculatedRectanglesObjects = [NSArray arrayWithArray:tempObjectRects];
        
        if(self.dataSource != nil){
            precalculatedContentSize.height = precalculatedHighestColumnHeight;
            precalculatedContentSize.width = (columnWidth * [dataSource numberColumns]) + (([dataSource numberColumns] -1) * self.columnSpacing);
        }
    }
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    if(attributes == nil){
        attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    }
    NSArray *columnRects = [precalculatedRectanglesObjects objectAtIndex:indexPath.section];
    CGRect frame = [[columnRects objectAtIndex:indexPath.row] CGRectValue];
    attributes.frame = frame;
    attributes.size = frame.size;
    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    // determine column intersection...
    NSMutableArray *interstectRects = [NSMutableArray array];
    for (int i = 0; i < precalculatedRectanglesColumns.count; i++) {
        CGRect columnRect = [[precalculatedRectanglesColumns objectAtIndex:i] CGRectValue];
        if (CGRectIntersectsRect(columnRect, rect)) {
            // find rectangles in column
            NSArray *columnRects = [precalculatedRectanglesObjects objectAtIndex:i];
            int numItems = columnRects.count;
            for (int j = 0; j < numItems; j++) {
                CGRect obRect = [[columnRects objectAtIndex:j] CGRectValue];
                if(CGRectIntersectsRect(obRect, rect)){
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
                    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                    attributes.frame = obRect;
                    NSLog(@"frame %@",NSStringFromCGRect(obRect));
                    attributes.size = obRect.size;
                    [interstectRects addObject:attributes];
                }
            }
        }
    }
    return interstectRects;
}



@end
