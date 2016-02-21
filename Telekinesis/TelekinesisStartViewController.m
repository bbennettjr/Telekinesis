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
    //Created a segue for this class.  This could be removed, I'm not sure if this had a purpose other than to test manual creation of segues.  All of these properties are part of this segue
@property (nonatomic, strong) UIStoryboardSegue *segue;
@property (nonatomic, strong) NSString *startTelekinesisSegue;
@property (nonatomic, strong) TelekinesisActionViewController *telekinesisActionViewController;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftReturnToTelekinesisAction;
@end

@implementation TelekinesisStartViewController
#pragma mark - Scaling
    //Scale the content to the size of the device.  These hard numbers and implementation could be played around with but the functionality works in its current state.
#define CONTENT_SCALE_FACTOR 180.0
#define CONTENT_OFFSET 8.0
-(CGFloat)contentScaleFactor{ return self.view.bounds.size.height / CONTENT_SCALE_FACTOR; }
-(CGPoint)contentOffset{ return CGPointMake(self.view.bounds.origin.x + [self contentScaleFactor] + CONTENT_OFFSET,self.view.bounds.origin.y + [self contentScaleFactor] + CONTENT_OFFSET); }

#pragma mark - Lazy Instantiation
    //instantiation of the properties above.  What more is there to say?
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

    //instantiation of the swipe gesture recognizer.  The swipe direction is "Left" in the current state.
-(UISwipeGestureRecognizer *)swipeLeftReturnToTelekinesisAction{
    if (!_swipeLeftReturnToTelekinesisAction) {
        _swipeLeftReturnToTelekinesisAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSegueFromTouchEventsWithSender:)];
        _swipeLeftReturnToTelekinesisAction.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swipeLeftReturnToTelekinesisAction;
}

#pragma mark - UI

    //The starting color in the following VC is chosen by the user, the button's information is sent to the the segue to later grab its background color.  At the first touch of a button, the swipe gesture recognizer is called and added to the view so the user can easily swipe back to the action if they backtrack.
- (IBAction)colorChosen:(UIButton *)sender {
    if (!self.view.gestureRecognizers) {
        [self.view addGestureRecognizer:self.swipeLeftReturnToTelekinesisAction];
    }
    [self performSegueFromTouchEventsWithSender:sender];
}

    //Button pushes lead to this method being called that performs the segue instantiated above.
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

    //currently un-used unwind segue.  delete this?
-(IBAction)unwindFromActionToStartTelekinesisViewController:(UIStoryboardSegue *)seque{
}

@end
