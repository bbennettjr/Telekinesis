    //
    //  TelekinesisModel.m
    //  Telekinesis
    //
    //  Created by Bradford Bennett Jr on 12/29/15.
    //  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
    //

#import "TelekinesisModel.h"

@interface TelekinesisModel ()
@property (nonatomic) float windowOriginX;
@property (nonatomic) float windowOriginY;
@property (nonatomic) float windowSizeWidth;
@property (nonatomic) float windowSizeHeight;
@property (nonatomic) float centerObjectOriginX;
@property (nonatomic) float centerObjectOriginY;
@property (nonatomic) float centerObjectSizeWidth;
@property (nonatomic) float centerObjectSizeHeight;
@end

@implementation TelekinesisModel
#pragma mark - Instantiation
    //primary initialization, cannot use CGRects because they are UI objects that would violate MVC. Input is an NSDictionary containing Window bounds and Center Object frame (origin and size).
-(instancetype)initWithWindowBounds:(NSDictionary *)bounds{
    self = [super init];
    if (self) {
            //setup
        self.windowOriginX = [[bounds objectForKey:@"WINDOW_ORIGIN_X"] floatValue];
        self.windowOriginY = [[bounds objectForKey:@"WINDOW_ORIGIN_Y"] floatValue];
        self.windowSizeWidth = [[bounds objectForKey:@"WINDOW_SIZE_WIDTH"] floatValue];
        self.windowSizeHeight = [[bounds objectForKey:@"WINDOW_SIZE_HEIGHT"] floatValue];
        self.centerObjectOriginX = [[bounds objectForKey:@"OBJECT_ORIGIN_X"] floatValue];
        self.centerObjectOriginY = [[bounds objectForKey:@"OBJECT_ORIGIN_Y"] floatValue];
        self.centerObjectSizeWidth = [[bounds objectForKey:@"OBJECT_SIZE_WIDTH"] floatValue];
        self.centerObjectSizeHeight = [[bounds objectForKey:@"OBJECT_SIZE_HEIGHT"] floatValue];
    }
    return self;
}

#pragma mark - Instance Methods
    //This is the primary method called on the model class.  Its input is an ObjectPositionAndColorData class object that is iterated through and each number is randomized, then pushed back to the object itself.  Those values are then used by the VC to update the view.
-(ObjectPositionAndColorData *)newRandomDataUsingCurrentObjectData:(ObjectPositionAndColorData *)objectData{
    NSDictionary *data = [objectData propertyList];
    NSMutableDictionary *mutableDataCopy = [data mutableCopy];
    NSArray *keys = [ObjectPositionAndColorData allKeys];
    NSNumber *number;
    NSString *positionStringInString = @"POSITION"; //we know the position keys contain this string

        //for each key in the ObjectPositionAndColorData class, grab the object for key and randomize each iteration
    for (NSString *key in keys) {
            //only do the operation if each object is of class NSNumber
        if ([[data objectForKey:key] isKindOfClass:[NSNumber class]]) {
            number = [data objectForKey:key];
            if ([key containsString:positionStringInString]) {
                [mutableDataCopy setValue:[self randomize:number withKey:key andPosition:YES] forKey:key];
            } else {
                [mutableDataCopy setValue:[self randomize:number withKey:key] forKey:key];
            }
        }
    }

    [objectData setPropertyList:mutableDataCopy];
    return objectData; //possible problem if you want to send the data back to the data object, need to protect in the setter of ObjectPositionAndColorData object so cant have runtime errors
}

    //The Randomize instance method takes an NSNumber input and does the largest arc4random function possible, divided by the arc4random_maximum.  This ensures many significant digits of variability and of course a number between 0 and 1.  The median 0.5 is the cutoff, random values above 0.5 increase the input number while numbers below decrease.
#define ARC4RANDOM_MAX      0x100000000
#define MEDIAN              0.5
#define COLOR_MAX_VALUE     1.0f
#define COLOR_MIN_VALUE     0.0f
#define INCREMENT_COLOR     0.05f
#define INCREMENT_POSITION  2.0f
-(NSNumber *)randomize:(NSNumber *)number withKey:(NSString *)key andPosition:(BOOL)isPosition{
        //local variables and randomized value
    float n = [number floatValue];
    double randomValue = ((double)arc4random() / ARC4RANDOM_MAX);
    NSLog(@"\nnumber: %@ \nrandomValue: %f",number, randomValue);

        //logic to change the values with their respective max and mins incorporated which cannot be bypassed
    if (randomValue > MEDIAN) {
        if (isPosition) {
            if ([key isEqualToString:@"X_POSITION_KEY"]) {
                    //is the new position off screen?
                if (n + INCREMENT_POSITION > (self.windowOriginX + self.windowSizeWidth - (self.centerObjectSizeWidth - self.centerObjectOriginX) / 2)) { //do nothing
                } else { n = n + INCREMENT_POSITION; }
            }
            if ([key isEqualToString:@"Y_POSITION_KEY"]) {
                    //is the new position off screen?
                if (n + INCREMENT_POSITION > (self.windowOriginY + self.windowSizeHeight - (self.centerObjectSizeHeight - self.centerObjectOriginY) / 2)) { //do nothing
                } else { n = n + INCREMENT_POSITION; }
            }
        }
        if (!isPosition) {
            if (n + INCREMENT_COLOR > COLOR_MAX_VALUE) { //do nothing
            } else { n = n + INCREMENT_COLOR; } //Increment the color if not above the limit
        }
    }else if (randomValue <= MEDIAN){
        if (isPosition) {
            if ([key isEqualToString:@"X_POSITION_KEY"]) {
                    //is the new position off screen?
                if (n - INCREMENT_POSITION < (self.windowOriginX + (self.centerObjectSizeWidth - self.centerObjectOriginX) / 2)) { //do nothing
                } else { n = n - INCREMENT_POSITION; }
            }
            if ([key isEqualToString:@"Y_POSITION_KEY"]) {
                    //is the new position off screen?
                if (n - INCREMENT_POSITION < (self.windowOriginY + (self.centerObjectSizeHeight - self.centerObjectOriginY) / 2)) { //do nothing
                } else { n = n - INCREMENT_POSITION; }
            }
        }
        if (!isPosition) {
            if (n - INCREMENT_COLOR < COLOR_MIN_VALUE) { //do nothing
            } else { n = n - INCREMENT_COLOR; } //Decrement the color if not below the limit
        }
    }
    number = [NSNumber numberWithFloat:n];
    return number; //general problems are the limits of both color and position, esp position in various ios environments.  Will need to think of a way to manage this condition
}
    //Companion method that defaults to NO for the position values and passes along the number.  This is for the color values
-(NSNumber *)randomize:(NSNumber *)number withKey:(NSString *)key{
    NSNumber *n = [self randomize:number withKey:key andPosition:NO];
    return n;
}
@end
