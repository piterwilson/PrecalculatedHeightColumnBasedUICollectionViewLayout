//
//  PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource.h
//
//  Created by J C Ospina Gonzalez on 09-04-15.
//

#import "PrecalculatedHeightObject.h"

@protocol PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource

/**
 * This call should return the Object that is positioned at the specified column and position (row) inside that column. The Object should implement the `PrecalculatedHeightObject` protocol. 
 *
 * @param colum
 * @param position
 *
 * @returns <PrecalculatedHeightObject>
 */
-(id <PrecalculatedHeightObject>)objectForColumn:(int)column position:(int)position;

/**
 * This call should return the number of Objects in the given column index.
 *
 * @param column Desired column index
 *
 * @returns number of objects in a given column index
 */
-(int)numberObjectsInColumn:(int)column;

/**
 * This call should return the number of columns to use on the layout.
 *
 * @returns number of columns in the layout
 */
-(int)numberColumns;
@end
