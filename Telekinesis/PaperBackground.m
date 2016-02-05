//
//  PaperBackground.m
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import "PaperBackground.h"

@implementation PaperBackground

#pragma mark - Scaling
#define CORNER_SCALE_FACTOR 180.0
#define CORNER_RADIUS 4.0
#define CORNER_OFFSET 3.0
-(CGFloat)cornerScaleFactor{ return self.bounds.size.height / CORNER_SCALE_FACTOR; }
-(CGFloat)cornerRadius{ return [self cornerScaleFactor] * CORNER_RADIUS; }
-(CGFloat)cornerOffset{ return [self cornerRadius] / CORNER_OFFSET; }


#define BACKGROUND_WHITE 0.9
#define BACKGROUND_ALPHA 1.0
    //custom drawRect to create rounded corners nicely overlaying the darker background
- (void)drawRect:(CGRect)rect {

        //Drawing Code
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:[self cornerRadius]];
        //fill and stroke the layout

    [[UIColor colorWithWhite:BACKGROUND_WHITE alpha:BACKGROUND_ALPHA] setFill];
    [[UIColor colorWithWhite:BACKGROUND_WHITE alpha:BACKGROUND_ALPHA] setStroke];
    [path addClip];
    [path fill];
    [path stroke];
}


@end
