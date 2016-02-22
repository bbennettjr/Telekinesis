//
//  TelekinesisActionViewController.h
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

    //This view controller sets the stage for the focus of the app.  The user can meditate or focus on the central object and see how its color and position changes with time.
@interface TelekinesisActionViewController : UIViewController
    //The starting color of the center object, which currently is chosen from the button on the intial VC then sent over through a segue.  This functionality should change in the future as its clunky
@property (nonatomic, strong) UIColor *startColor;
    //This doesn't seem to be used, delete?
@property (nonatomic) CGFloat number;
@end
