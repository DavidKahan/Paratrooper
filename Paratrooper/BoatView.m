//
//  BoatView.m
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/16/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//

#import "BoatView.h"

@implementation BoatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *boat = [UIImage imageNamed:@"boat.png"];
        UIImageView *boatView = [[UIImageView alloc] initWithImage:boat];
        boatView.frame = CGRectMake(0.0, -40.0, 100.0, 100.0);
        [self addSubview:boatView];
    }
    return self;
}

@end
