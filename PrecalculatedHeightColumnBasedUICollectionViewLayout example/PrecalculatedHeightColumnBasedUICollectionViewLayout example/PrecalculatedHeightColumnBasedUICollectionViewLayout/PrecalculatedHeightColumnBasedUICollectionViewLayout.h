//
//  PrecalculatedHeightColumnBasedUICollectionViewLayout.h
//
//  Created by J C Ospina Gonzalez on 09-04-15.
//

#import <UIKit/UIKit.h>
#import "PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource.h"

/**
 UICollectionViewLayout where the items are placed in vertical columns that are layed out side by side.
 
 The height of the items is provided by the items themselves (PrecalculatedHeightObject protocol). This is useful when the height will be variable and depending on the item's properties.
 
 The width of the columns is specified by the layout. (columnWidth property) as is the spacing (internal) between columns (columSpacing,rowSpacing properties)
 
 Example :
 
 The data structure
 
 [
    [
        {precalculatedHeght : 1}
    ],
    [
        {precalculatedHeght : 1},
        {precalculatedHeght : 2},
        {precalculatedHeght : 3}
    ],
    [
        {precalculatedHeght : 1},
        {precalculatedHeght : 2},
        {precalculatedHeght : 2}
    ]
 ]
 
 
 Results in:
 
 ┌─────┬─────┬─────┐
 |  1  |  1  |  1  |
 └─────┼─────┼─────┤
       |  2  |  2  |
       |     |     |
       ├─────┼─────┤
       |  3  |  2  |
       |     |     |
       |     ├─────┘
       └─────┘
 
 */

@interface PrecalculatedHeightColumnBasedUICollectionViewLayout : UICollectionViewLayout{
    
    /**
     * Max contentSize for the whole layout. Precalculated for performance in [PrecalculatedHeightColumnBasedUICollectionViewLayout prepareForLayout]
     */
    CGSize precalculatedContentSize;
    
    /**
     * Bi-dimensional NSArray of CGRect values for each object represented in the layout. Precalculated for performance in [PrecalculatedHeightColumnBasedUICollectionViewLayout prepareForLayout]
     */
    NSArray *precalculatedRectanglesObjects;
    
    /**
     * NSArray of CGRect values for each column represented in the layout. Precalculated for performance in [PrecalculatedHeightColumnBasedUICollectionViewLayout prepareForLayout]
     */
    NSArray *precalculatedRectanglesColumns;
    
}

/**
 * DataSource object that conforms to the PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource to provide the details needed by the layout.
 */
@property (nonatomic,weak) id<PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource> dataSource;

/**
 * Width for each one of the columns
 */
@property (nonatomic) float columnWidth;

/**
 * Internal spacing between columns
 */
@property (nonatomic) float columnSpacing;

/**
 * Internal spacing between rows
 */
@property (nonatomic) float rowSpacing;

/**
 * Whether or not to permit horizontal scrolling
 */
@property (nonatomic) BOOL horizontalScrollEnabled;

/**
 * Whether or not to permit vertical scrolling
 */
@property (nonatomic) BOOL verticalScrollEnabled;

@end
