//
//  ParatrooperView.m
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/16/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//

#import "ParatrooperView.h"

@implementation ParatrooperView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        UIImage *parachutist = [UIImage imageNamed:@"parachutist.png"];
        UIImageView *parachutistView = [[UIImageView alloc] initWithImage:parachutist];
        parachutistView.frame = CGRectMake(-26.0, 0.0, 69.6f, 100.0f);
        [self addSubview:parachutistView];
    }
    return self;
}

@end
