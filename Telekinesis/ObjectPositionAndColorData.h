//
//  ObjectPositionAndColorData.h
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 1/3/16.
//  Copyright © 2016 Bradford Bennett Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectPositionAndColorData : NSObject
@property (nonatomic) NSDictionary *propertyList;
@property (nonatomic) NSNumber *xPosition;
@property (nonatomic) NSNumber *yPosition;
@property (nonatomic) NSNumber *red;
@property (nonatomic) NSNumber *green;
@property (nonatomic) NSNumber *blue;
-(instancetype)initWithPositionsX:(float)x andY:(float)y andColorsRed:(float)red andGreen:(float)green andBlue:(float)blue;

+(NSArray *)allKeys;
@end
