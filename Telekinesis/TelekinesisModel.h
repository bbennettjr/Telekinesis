//
//  TelekinesisModel.h
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/29/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectPositionAndColorData.h"

@interface TelekinesisModel : NSObject
    //primary initialization, cannot use CGRects because they are UI objects that would violate MVC. Input is an NSDictionary containing Window bounds and Center Object frame (origin and size).
-(instancetype)initWithWindowBounds:(NSDictionary *)bounds;

    //Using the current data for the objects position and color information, we will randomize the new parameters and return them in the dictionary format for ease of data access.
-(ObjectPositionAndColorData *)newRandomDataUsingCurrentObjectData:(ObjectPositionAndColorData *)data;
@end
