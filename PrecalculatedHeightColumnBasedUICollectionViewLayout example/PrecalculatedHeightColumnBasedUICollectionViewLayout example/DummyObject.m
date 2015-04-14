//
//  DummyObject.m
//
//  Created by J C Ospina Gonzalez on 14-04-15.
//

#import "DummyObject.h"
@implementation DummyObject
@synthesize precalculatedHeight;

-(NSString *)description{
    return [NSString stringWithFormat:@"Dummy object of height %f pixels",precalculatedHeight];
}

@end
