//
//  CenterObject.m
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import "CenterObject.h"

@interface CenterObject ()
@end

@implementation CenterObject
#pragma mark - Scaling
    //scale the corners to fit devices of different sizes
#define CONTENT_SCALE_FACTOR 180.0
#define CONTENT_RADIUS 4.0
-(CGFloat)contentScaleFactor{ return self.bounds.size.height / CONTENT_SCALE_FACTOR; }
-(CGFloat)contentRadius{ return [self contentScaleFactor] * CONTENT_RADIUS; }

#pragma mark - instantiation
    //designated initializer
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
    //Tell the view to redraw when any intrinsic variables change (eg. position)
-(void)setup{
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

#pragma mark - Lazy Instantiation
@synthesize startColor = _startColor;
-(UIColor *)startColor{
    return !_startColor ? _startColor = [UIColor blackColor] : _startColor;
}
-(void)setStartColor:(UIColor *)startColor{
    _startColor = startColor;
        //setNeedsDisplay tells the view to redraw
    [self setNeedsDisplay];
}

#define DIAMETER 50
    //Getter and setter for xPosition factors in the Diameter of the shape.  Subtracting the Diameter is essentially saying we want to set the center of the object, so to do that the actual corner we will set subtracts radius in both X and Y.  Also includes boundaries for the Setter.
@synthesize xPosition = _xPosition;
-(CGFloat)xPosition{
    if (!_xPosition) {
        _xPosition = self.center.x - DIAMETER / 2;
    }
    return _xPosition;
}
-(void)setXPosition:(CGFloat)xPosition{
    if (xPosition <= (self.frame.origin.x + self.frame.size.width + DIAMETER) && xPosition >= self.frame.origin.x) {
        _xPosition = xPosition - DIAMETER / 2;
        [self setNeedsDisplay];
    }
}
    //Getter and setter for yPosition factors in the Diameter of the shape.  Subtracting the Diameter is essentially saying we want to set the center of the object, so to do that the actual corner we will set subtracts radius in both X and Y. Also includes boundaries for the Setter.
@synthesize yPosition = _yPosition;
-(CGFloat)yPosition{
    if (!_yPosition) {
        _yPosition = self.center.y - DIAMETER / 2;
    }
    return _yPosition;
}
-(void)setYPosition:(CGFloat)yPosition{
    if (yPosition <= (self.frame.origin.y + self.frame.size.height + DIAMETER) && yPosition >= self.frame.origin.y) {
        _yPosition = yPosition - DIAMETER / 2;
        [self setNeedsDisplay];
    }
}

#pragma mark - drawing
- (void)drawRect:(CGRect)rect {
    // Drawing code, specific for a circle currently.  Ambiguous wording of center "object" because this could be any number of shapes or images in the future.  For testing and building purposes it is a circle.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.xPosition, self.yPosition, DIAMETER, DIAMETER)];
    [self.startColor setFill];
    [path addClip];
    [path fill];
}

    //This code was supposed to update the object's center with a new CGPoint, but did not work.  Maybe if I added setNeedsDisplay now that I think about it? That would greatly simplify the above code
-(void)updateCenter:(CGPoint)center{
    self.center = center;
}
@end
