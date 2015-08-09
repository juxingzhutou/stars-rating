//
//  BSStarRatingView.h
//  StarRating
//
//  Created by juxingzhutou on 15/8/9.
//  Copyright (c) 2015年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSRatingViewDelegate

@required
-(void)ratingChanged:(CGFloat)newRating;

@end

@interface BSStarRatingView : UIView

@property (nonatomic, assign) NSUInteger starAmount;
@property (nonatomic, assign) CGFloat    rating;
@property (nonatomic, assign) BOOL       editable;
@property (nonatomic, assign) BOOL       allowHalfSelected;

@property (nonatomic, assign) id<BSRatingViewDelegate> delegate;

@end