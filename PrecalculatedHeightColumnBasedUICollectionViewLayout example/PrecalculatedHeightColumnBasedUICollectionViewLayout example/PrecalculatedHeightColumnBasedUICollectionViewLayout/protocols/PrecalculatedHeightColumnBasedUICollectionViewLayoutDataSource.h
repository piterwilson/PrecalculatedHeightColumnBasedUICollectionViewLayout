//
//  PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource.h
//
//  Created by J C Ospina Gonzalez on 09-04-15.
//

#import "PrecalculatedHeightObject.h"

@protocol PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource
-(id <PrecalculatedHeightObject>)objectForColumn:(int)column position:(int)position;
-(int)numberObjectsInColumn:(int)column;
-(int)numberColumns;
@end
