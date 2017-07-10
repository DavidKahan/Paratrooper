//
//  View.h
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/16/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaneView;
@class ParatrooperView;
@class BoatView;

@interface View : UIView

@property (nonatomic, assign) CGPoint parachuteSpeed;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int life;
@property (nonatomic, readonly) PlaneView *plane;
@property (nonatomic, readonly) ParatrooperView *parachute;
@property (nonatomic, readonly) BoatView *boat;

@end
