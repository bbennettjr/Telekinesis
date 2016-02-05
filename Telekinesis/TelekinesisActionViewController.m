//
//  TelekinesisActionViewController.m
//  Telekinesis
//
//  Created by Bradford Bennett Jr on 12/22/15.
//  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
//

#import "TelekinesisActionViewController.h"
#import "TelekinesisModel.h"
#import "CenterObject.h"
#import "ObjectPositionAndColorData.h"
#import "TelekinesisModel.h"
#import "TelekinesisActionPaperBackground.h"

@interface TelekinesisActionViewController ()
@property (nonatomic, strong) CenterObject *telekinesisObject;
@property (nonatomic, strong) ObjectPositionAndColorData *objectData;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TelekinesisModel *model;
@property (weak, nonatomic) IBOutlet TelekinesisActionPaperBackground *paperBackground;
@end

@implementation TelekinesisActionViewController

#pragma mark - ViewController life cycle
#define TIMER_INTERVAL 0.5
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.telekinesisObject setStartColor:self.startColor];

        //start the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                                  target:self
                                                selector:@selector(updateUI:)
                                                userInfo:nil
                                                 repeats:YES];
    self.timer.tolerance = 0.02; //this adds flexibility to the thread for better power consumption
    NSLog(@"Is the timer valid: %d", self.timer.isValid);
}

#pragma mark - Lazy Instantiation
-(CenterObject *)telekinesisObject{
    if (!_telekinesisObject) {
        _telekinesisObject = [[CenterObject alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_telekinesisObject];
    }
    return _telekinesisObject;
}

-(ObjectPositionAndColorData *)objectData{
    if (!_objectData) {
        CGFloat red, green, blue, alpha;
            //Call
        [self.startColor getRed: &red
                          green: &green
                           blue: &blue
                          alpha: &alpha];
        NSLog(@"red = %f. Green = %f. Blue = %f. Alpha = %f",
              red,
              green,
              blue,
              alpha);
        _objectData = [[ObjectPositionAndColorData alloc] initWithPositionsX:self.telekinesisObject.center.x
                                                                        andY:self.telekinesisObject.center.y
                                                                andColorsRed:red
                                                                    andGreen:green
                                                                     andBlue:blue];
    }
    return _objectData;
}

    //Initialize the model, if the model is not allocated in the heap, create it with the view information so boundaries can be set within the model for the values to be incremented and decremented.
-(TelekinesisModel *)model{
    if (!_model) {
        NSNumber *windowOriginX = [NSNumber numberWithFloat:self.paperBackground.frame.origin.x];
        NSNumber *windowOriginY = [NSNumber numberWithFloat:self.paperBackground.frame.origin.y];
        NSNumber *windowSizeWidth = [NSNumber numberWithFloat:self.paperBackground.frame.size.width];
        NSNumber *windowSizeHeight = [NSNumber numberWithFloat:self.paperBackground.frame.size.height];
        NSNumber *centerObjectOriginX = [NSNumber numberWithFloat:0.0f];
        NSNumber *centerObjectOriginY = [NSNumber numberWithFloat:0.0f];
        NSNumber *centerObjectSizeWidth = [NSNumber numberWithFloat:50.0f];
        NSNumber *centerObjectSizeHeight = [NSNumber numberWithFloat:50.0f]; //MAGIC NUMBERS JUST BECAUSE EASY FIX, WILL FIX LATER!!
        NSArray *boundsData = @[windowOriginX, windowOriginY, windowSizeWidth, windowSizeHeight, centerObjectOriginX, centerObjectOriginY, centerObjectSizeWidth, centerObjectSizeHeight];
        NSArray *keys = @[@"WINDOW_ORIGIN_X", @"WINDOW_ORIGIN_Y", @"WINDOW_SIZE_WIDTH", @"WINDOW_SIZE_HEIGHT", @"OBJECT_ORIGIN_X", @"OBJECT_ORIGIN_Y", @"OBJECT_SIZE_WIDTH", @"OBJECT_SIZE_HEIGHT"];
        NSDictionary *boundsDictionary = [NSDictionary dictionaryWithObjects:boundsData forKeys:keys];
        _model = [[TelekinesisModel alloc] initWithWindowBounds:boundsDictionary];
    }
    return _model;
}

#pragma mark - UI
-(void)updateUI:(NSTimer *)timer{
        //continually update the UI
    self.objectData = [self.model newRandomDataUsingCurrentObjectData:self.objectData];
    [self setObjectColorAndPosition];
}

-(void)setObjectColorAndPosition{
        //use the new object data information to store the new position and color
        //Color update
    [self.telekinesisObject setStartColor:[UIColor colorWithRed:[self.objectData.red floatValue] green:[self.objectData.green floatValue] blue:[self.objectData.blue floatValue] alpha:1.0]];
        //X position update
    [self.telekinesisObject setXPosition:[self.objectData.xPosition floatValue]];
        //Y position update
    [self.telekinesisObject setYPosition:[self.objectData.yPosition floatValue]];
}

@end
