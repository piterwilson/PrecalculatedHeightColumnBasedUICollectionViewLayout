//
//  DummyObject.h
//
//  Created by J C Ospina Gonzalez on 14-04-15.
//

#import <Foundation/Foundation.h>
#import "PrecalculatedHeightObject.h"

@interface DummyObject : NSObject<PrecalculatedHeightObject>
@property (nonatomic) float precalculatedHeight;
@end
