//
//  CenterObject.h
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

    //Center Object is the central object to be randomized by location and color.  The center point is already implemented by superclass.  below are the three colors to make up its instantaneous UIColor
@interface CenterObject : UIView
@property (nonatomic) CGFloat xPosition;
@property (nonatomic) CGFloat yPosition;
@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat blue;
@property (nonatomic) CGFloat green;
@property (nonatomic, strong) UIColor *startColor;

-(void)updateCenter:(CGPoint)center;
@end
