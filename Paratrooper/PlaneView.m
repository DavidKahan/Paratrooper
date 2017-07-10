//
//  PlaneView.m
//  Paratrooper
//
//  Created by Pepperi Ltd on 6/17/17.
//  Copyright © 2017 David Ltd. All rights reserved.
//

#import "PlaneView.h"

@implementation PlaneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *plane = [UIImage imageNamed:@"plane.png"];
        UIImageView *planeView = [[UIImageView alloc] initWithImage:plane];
        planeView.frame = CGRectMake(-26.0, 0.0, 69.6f, 100.0f);
        [self addSubview:planeView];
    }
    return self;
}


@end
