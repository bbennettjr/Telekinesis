//
//  ObjectPositionAndColorData.h
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 1/3/16.
//  Copyright © 2016 Bradford Bennett Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectPositionAndColorData : NSObject
    //properties of the center object are stored in this object, ObjectPositionAndColorData.  My names aren't too clever :).  As you expect this contains position and color data that will be used by the model and fed back to the VC to update the changing variables on screen.  The property list is an NSDictionary storing all of the data in one convenient place.
@property (nonatomic) NSDictionary *propertyList;
@property (nonatomic) NSNumber *xPosition;
@property (nonatomic) NSNumber *yPosition;
@property (nonatomic) NSNumber *red;
@property (nonatomic) NSNumber *green;
@property (nonatomic) NSNumber *blue;

    //designated initializer of this class, which requires the current position and color data of the object in question
-(instancetype)initWithPositionsX:(float)x andY:(float)y andColorsRed:(float)red andGreen:(float)green andBlue:(float)blue;

    //class method that returns an NSarray of all the key values used in the property list.  This is used to give the downstream user a way to reliably access the data in the property list.
+(NSArray *)allKeys;
@end
