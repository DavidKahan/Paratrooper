//
//  ViewController.m
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/16/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//
#import "ViewController.h"
#import "View.h"
#import "PlaneView.h"
#import "ParatrooperView.h"
#import "BoatView.h"
#import <CoreMotion/CoreMotion.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CMMotionManager *motion_;
    View *_mainView;
    UIButton *_startButton;
    UIView *_overlay;
    CADisplayLink *_timer;
    BOOL touching_;
    float accelX_;
}

- (id)init
{
    self = [super init];
    if (self) {
        motion_ = [[CMMotionManager alloc] init];
        [motion_ startAccelerometerUpdates];
        accelX_ = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    int width = screen.size.width;
    int height = screen.size.height;
    
    _mainView = [[View alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _startButton.frame = CGRectMake(width / 2 - 100 / 2, height / 2 - 50 / 2, 100.0, 50.0);
    [_startButton setTitle:@"Play!" forState:UIControlStateNormal];
    [_startButton addTarget:self
                     action:@selector(startGame:)
           forControlEvents:UIControlEventTouchUpInside];
    
    _overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlay.backgroundColor = [UIColor whiteColor];
    _overlay.alpha = 0.6f;
    
    [self.view addSubview:_mainView];
    [self.view addSubview:_overlay];
    [self.view addSubview:_startButton];
}

- (void)startGame:(id)sender
{
    [self resumeGame];
    
    _startButton.hidden = YES;
    _overlay.hidden = YES;
    
    _mainView.score = 0;
    _mainView.life = 3;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching_ = YES;
    [self respondToTouch:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self respondToTouch:touches];
}

- (void)respondToTouch: (NSSet *)touches{
    BoatView *boat = _mainView.boat;
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_mainView];
    
    float y = boat.frame.origin.y;
    float x = location.x;
    
    boat.center = location.x > 30 ? CGPointMake(x, y + 10) : CGPointMake(30.0, y + 10);
}


- (void)accelerometerMoved:(CMAccelerometerData *)accelData {
    BoatView *boat = _mainView.boat;
    float y = boat.frame.origin.y;
    float x = boat.center.x + (accelX_ * 20);
    x = fminf(x, (self.view.bounds.size.width + (boat.frame.size.width/2) - 30));
    boat.center = x > 30 ? CGPointMake(x, y + 10) : CGPointMake(30.0, y + 10);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    touching_ = NO;
}

- (float)filterAccelXData:(CMAccelerometerData *)accelData {
    accelX_ = (accelData.acceleration.x * 0.1) + (accelX_ * (1.0 - 0.1));
    return accelX_;
}

- (void)gameLoop
{
    PlaneView *plane = _mainView.plane;
    ParatrooperView *parachute = _mainView.parachute;
    CGPoint speed = _mainView.parachuteSpeed;
    BoatView *boat = _mainView.boat;
    
    if (!touching_)
    {
        [self accelerometerMoved:motion_.accelerometerData];
    }
    plane.center = CGPointMake(plane.center.x -4, plane.center.y);
    parachute.center = CGPointMake(parachute.center.x, parachute.center.y + speed.y);
    
    BOOL planeDidHitSide = plane.center.x - plane.frame.size.width / 2 < 0;

    if (planeDidHitSide) {
        CGPoint resetToStart = CGPointMake([[UIScreen mainScreen] bounds].size.width - 20, 60.0);
        _mainView.plane.center = resetToStart;
    }

    BOOL parachuteDidHitBoat = CGRectIntersectsRect(parachute.frame, boat.frame) && parachute.frame.origin.y + parachute.frame.size.height <= _mainView.boat.frame.origin.y + 10;
    
    if (parachuteDidHitBoat) {
        [self parachuterDidHitBoat];
        
        parachute.center = plane.center;
    }
    
    if (parachute.center.y + parachute.frame.size.height / 2 >= _mainView.bounds.size.height) {
        [self parachuterDidSink];
    }
}

- (void)parachuterDidSink
{
    [_timer removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_timer invalidate];
    _timer = nil;
    
    CGPoint resetCenter = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2 - 20, 60.0);
    _mainView.parachute.center = resetCenter;
    _mainView.parachuteSpeed = CGPointMake(2.0, 2.0);
    
    _mainView.life--;
    if (_mainView.life == 0) {
        _startButton.hidden = NO;
        _overlay.hidden = NO;
    } else {
        [self resumeGame];
    }
    
}

- (void)resumeGame
{
    float startYSpeed = 1.0;
    float startXSpeed = 1.0;

    _mainView.parachuteSpeed = CGPointMake(startXSpeed, startYSpeed);
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)parachuterDidHitBoat
{
    CGPoint speed = _mainView.parachuteSpeed;
    float y = speed.y + 0.2;
    
    _mainView.parachuteSpeed = CGPointMake(speed.x, y);
    
    _mainView.score = _mainView.score + 10;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
