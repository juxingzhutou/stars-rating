//
//  MainViewController.h
//  StarRating
//
//  Created by juxingzhutou on 15/8/9.
//  Copyright (c) 2015年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStarRatingView.h"

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet BSStarRatingView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
