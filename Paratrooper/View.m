//
//  View.m
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/16/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//
#import "PlaneView.h"
#import "ParatrooperView.h"
#import "BoatView.h"
#import "View.h"

@implementation View
{
    UILabel *scoreDisplay;
    UILabel *lifeDisplay;
    UIButton *startButton;
}

@synthesize parachuteSpeed = _parachuteSpeed;
@synthesize score = _score;
@synthesize life = _life;
@synthesize plane = _plane;
@synthesize parachute = _parachute;
@synthesize boat = _boat;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect screen = [UIScreen mainScreen].bounds;
        int width = screen.size.width;
        int height = screen.size.height;
        
        CGRect planeFrame = CGRectMake((width / 2) - 30.0, 20.0f, 18.0f, 100.0f);
        CGRect parachuteFrame = CGRectMake((width / 2) - 30.0, 20.0f, 18.0f, 100.0f);
        CGRect boatFrame = CGRectMake((width / 2) - 60.0, height - 90,  60.0, 20.0);
        
        UIImage *bg = [UIImage imageNamed:@"background.png"];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        UIImage *sea = [UIImage imageNamed:@"sea.png"];
        UIImageView *seaView = [[UIImageView alloc] initWithImage:sea];
        if (self.bounds.size.height > 480.0f) {
            NSLog(@"iPhone5");
            bgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            seaView.frame = CGRectMake(0, height - 60, self.bounds.size.width, self.bounds.size.height/4);

        }
        [self addSubview:bgView];
        [self addSubview:seaView];
        _plane = [[PlaneView alloc] initWithFrame:planeFrame];
        _plane.layer.anchorPoint = CGPointMake(0.5, 0.05);
        _parachute = [[ParatrooperView alloc] initWithFrame:parachuteFrame];
        _parachute.layer.anchorPoint = CGPointMake(0.5, 0.05);
        _boat = [[BoatView alloc] initWithFrame:boatFrame];
        
        scoreDisplay = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
        scoreDisplay.textColor = [UIColor blackColor];
        scoreDisplay.backgroundColor = [UIColor clearColor];
        lifeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
        lifeDisplay.textColor = [UIColor blackColor];
        lifeDisplay.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_plane];
        [self addSubview:_parachute];
        [self addSubview:_boat];
        [self addSubview:scoreDisplay];
        [self addSubview:lifeDisplay];
    }
    return self;
}

- (void)setScore:(int)score
{
    _score = score;
    scoreDisplay.text = [NSString stringWithFormat:@"Score: %d", _score];
}

-(void)setLife:(int)life
{
    _life = life;
    lifeDisplay.text = [NSString stringWithFormat:@"Lives: %d", _life];
}

@end
