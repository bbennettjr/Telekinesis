    //
    //  ObjectPositionAndColorData.m
    //  Telekinesis
    //
    //  Created by Bradford Bennett Jr on 1/3/16.
    //  Copyright © 2016 Bradford Bennett Jr. All rights reserved.
    //

#import "ObjectPositionAndColorData.h"

@interface ObjectPositionAndColorData ()
@end

@implementation ObjectPositionAndColorData
    //static strings that make up the KEY values
static NSString *const X_POSITION_KEY = @"X_POSITION_KEY";
static NSString *const Y_POSITION_KEY = @"Y_POSITION_KEY";
static NSString *const RED_KEY = @"RED_KEY";
static NSString *const GREEN_KEY = @"GREEN_KEY";
static NSString *const BLUE_KEY = @"BLUE_KEY";

#pragma mark - Initializer
    //Designated initializer
-(instancetype)initWithPositionsX:(float)x andY:(float)y andColorsRed:(float)red andGreen:(float)green andBlue:(float)blue{
    self = [super init];
    if (self) {
            //if the object is created, wrap the given values in NSNumber format and send the pointers to the stack
        _xPosition = [[NSNumber alloc] initWithFloat:x];
        _yPosition = [[NSNumber alloc] initWithFloat:y];
        _red = [[NSNumber alloc] initWithFloat:red];
        _green = [[NSNumber alloc] initWithFloat:green];
        _blue = [[NSNumber alloc] initWithFloat:blue];
    }
    return self;
}

#pragma mark - Instance Methods
    //Create the setter and getter so must synchronize.  The property list getter will return an NSDictionary of the values initialized.  The setter allows the user to send a property list to the object, which parses out the correct KEY and adds the object to that KEY.  This is a fancy way of saying it keeps track of the data in one dictionary.
@synthesize propertyList = _propertyList;
-(NSDictionary *)propertyList{
    _propertyList = [[NSDictionary alloc] initWithObjects:self.allValues forKeys:[ObjectPositionAndColorData allKeys]];
    return _propertyList;
}
-(void)setPropertyList:(NSDictionary *)propertyList{
    NSArray *keys = [propertyList allKeys];
    for (NSString *key in keys) {
        if ([[ObjectPositionAndColorData allKeys] containsObject:key]){
            if ([[propertyList objectForKey:key] isKindOfClass:[NSNumber class]]) {
                if ([key isEqualToString:X_POSITION_KEY]) self.xPosition = [propertyList objectForKey:key];
                if ([key isEqualToString:Y_POSITION_KEY]) self.yPosition = [propertyList objectForKey:key];
                if ([key isEqualToString:RED_KEY]) self.red = [propertyList objectForKey:key];
                if ([key isEqualToString:GREEN_KEY]) self.green = [propertyList objectForKey:key];
                if ([key isEqualToString:BLUE_KEY]) self.blue = [propertyList objectForKey:key];
            }
        }
    }
}

#pragma mark - Instance Methods
    //Returns the value of each property in an NSArray
-(NSArray *)allValues{
    return @[self.xPosition, self.yPosition, self.red, self.green, self.blue];
}

    //Return the current state of the data in string format
-(NSString *)description{
    NSMutableString *descr = [NSMutableString stringWithFormat:@"X Position: %@ \nY Position: %@ \nRed: %@ \nGreen: %@ \nBlue: %@\n", self.xPosition, self.yPosition, self.red, self.green, self.blue];
    return descr;
}

#pragma mark - Class Methods
    //Return all keys to the user
+(NSArray *)allKeys{
    return @[X_POSITION_KEY, Y_POSITION_KEY, RED_KEY, GREEN_KEY, BLUE_KEY];
}


@end
