//
//  TelekinesisActionPaperBackground.m
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import "TelekinesisActionPaperBackground.h"

@implementation TelekinesisActionPaperBackground

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];

        //Paths to create the central horizontal and vertical lines dividing the screen into quadrants
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2, self.bounds.origin.y)];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2, self.bounds.origin.y + self.bounds.size.height)];
    [path moveToPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height / 2)];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height / 2)];
    [[UIColor lightGrayColor] setStroke];
    [path stroke];

}

@end
