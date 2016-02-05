    //
    //  TelekinesisStartViewController.m
    //  Telekinesis
    //
    //  Created by Bradford Bennett Jr on 12/22/15.
    //  Copyright © 2015 Bradford Bennett Jr. All rights reserved.
    //

#import "TelekinesisStartViewController.h"
#import "TelekinesisActionViewController.h"
#import "PaperBackground.h"

@interface TelekinesisStartViewController ()
@property (nonatomic, strong) UIStoryboardSegue *segue;
@property (nonatomic, strong) NSString *startTelekinesisSegue;
@property (nonatomic, strong) TelekinesisActionViewController *telekinesisActionViewController;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftReturnToTelekinesisAction;
@end

@implementation TelekinesisStartViewController
#pragma mark - Scaling
#define CONTENT_SCALE_FACTOR 180.0
#define CONTENT_OFFSET 8.0
-(CGFloat)contentScaleFactor{ return self.view.bounds.size.height / CONTENT_SCALE_FACTOR; }
-(CGPoint)contentOffset{ return CGPointMake(self.view.bounds.origin.x + [self contentScaleFactor] + CONTENT_OFFSET,self.view.bounds.origin.y + [self contentScaleFactor] + CONTENT_OFFSET); }

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Lazy Instantiation
-(UIStoryboardSegue *)segue{
    if (!_segue) {
        _segue = [[UIStoryboardSegue alloc] initWithIdentifier:self.startTelekinesisSegue source:self destination:self.telekinesisActionViewController];
    }
    return _segue;
}

-(NSString *)startTelekinesisSegue{
    return !_startTelekinesisSegue ? _startTelekinesisSegue = @"startTelekinesis" : _startTelekinesisSegue;
}

-(TelekinesisActionViewController *)telekinesisActionViewController{
    return !_telekinesisActionViewController ? _telekinesisActionViewController = [[TelekinesisActionViewController alloc] init] : _telekinesisActionViewController;
}

-(UISwipeGestureRecognizer *)swipeLeftReturnToTelekinesisAction{
    if (!_swipeLeftReturnToTelekinesisAction) {
        _swipeLeftReturnToTelekinesisAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSegueFromTouchEventsWithSender:)];
        _swipeLeftReturnToTelekinesisAction.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swipeLeftReturnToTelekinesisAction;
}

#pragma mark - UI
- (IBAction)colorChosen:(UIButton *)sender {
    if (!self.view.gestureRecognizers) {
        [self.view addGestureRecognizer:self.swipeLeftReturnToTelekinesisAction];
    }
    [self performSegueFromTouchEventsWithSender:sender];
}

-(void)performSegueFromTouchEventsWithSender:(id)sender{
    [self performSegueWithIdentifier:@"startTelekinesis" sender:sender];
}

#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
       TelekinesisActionViewController *destination = (TelekinesisActionViewController *)[segue destinationViewController];
        destination.startColor = button.backgroundColor;
    }
}

-(IBAction)unwindFromActionToStartTelekinesisViewController:(UIStoryboardSegue *)seque{
}

@end
