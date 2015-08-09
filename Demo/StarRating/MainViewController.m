//
//  MainViewController.m
//  StarRating
//
//  Created by juxingzhutou on 15/8/9.
//  Copyright (c) 2015年 bluntsword. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <BSRatingViewDelegate>

@end

@implementation MainViewController

- (instancetype)init {
    self = [super initWithNibName:@"MainView" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.starRatingView.delegate = self;
    self.starRatingView.starAmount = 10;
    self.label.text = @"0.0";
}

-(void)ratingChanged:(CGFloat)newRating {
    self.label.text = [NSString stringWithFormat:@"%.1lf", newRating];
}

@end
