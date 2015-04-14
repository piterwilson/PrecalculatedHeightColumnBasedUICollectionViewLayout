//
//  ViewController.h
//  PrecalculatedHeightColumnBasedUICollectionViewLayout example
//
//  Created by J C Ospina Gonzalez on 14-04-15.
//

#import <UIKit/UIKit.h>
#import "PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource>{
    
    // model with dummie content
    NSMutableArray *content;
    
    // number of columns to present
    int numberColumns;
}

// UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

