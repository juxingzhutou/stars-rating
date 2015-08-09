//
//  BSStarRatingView.m
//  StarRating
//
//  Created by juxingzhutou on 15/8/9.
//  Copyright (c) 2015年 bluntsword. All rights reserved.
//

#import "BSStarRatingView.h"

#define IMAGE_EMPTY     [UIImage imageNamed:@"empty_star"]
#define IMAGE_FULL      [UIImage imageNamed:@"full_star"]
#define IMAGE_HALF      [UIImage imageNamed:@"half_star"]

@interface BSStarRatingView ()

@property (nonatomic, strong) NSArray *stars;

@end

@implementation BSStarRatingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (void)initProperties {
    self.allowHalfSelected = YES;
    self.editable = YES;
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)initSubviews {
    for (UIView *subview in self.stars) {
        [subview removeFromSuperview];
    }
    
    NSMutableArray *stars = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < self.starAmount; ++i) {
        UIImageView *starView = [[UIImageView alloc] initWithImage:IMAGE_EMPTY];
        [stars addObject:starView];
        [self addSubview:starView];
        starView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        if (i == 0) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        } else {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:stars[i-1] attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:stars[i-1] attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        }
        
        if (i == self.starAmount - 1) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:starView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        }
    }
    
    self.stars = stars;
}

- (void)setRating:(CGFloat)rating {
    if (rating > self.starAmount) {
        rating = self.starAmount;
    } else if (rating < 0) {
        rating = 0;
    }
    
    int smaller = MAX(MIN(rating, _rating), 0);
    int bigger = MAX(rating, _rating) - 0.1;
    
    _rating = rating;
    
    for (; smaller <= bigger; smaller++) {
        if (rating - smaller > 0.74999) {
            [self.stars[smaller] setImage:IMAGE_FULL];
        } else if (rating - smaller > 0.24999) {
            [self.stars[smaller] setImage:IMAGE_HALF];
        } else {
            [self.stars[smaller] setImage:IMAGE_EMPTY];
        }
    }
    
    [self.delegate ratingChanged:_rating];
}

#pragma -mark touchs event

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [self handleTouch:[touches anyObject]];
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    [self handleTouch:[touches anyObject]];
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event{
    [self handleTouch:[touches anyObject]];
}

- (void)handleTouch:(UITouch*)touch {
    CGPoint pt = [touch locationInView:self];
    
    CGFloat newRating = pt.x / self.frame.size.width * self.starAmount;
    if (self.allowHalfSelected == NO) {
        newRating = (int)newRating;
    }
    self.rating = newRating;
}

#pragma mark - Accessors

- (void)setStarAmount:(NSUInteger)starAmount {
    _starAmount = starAmount;
    
    [self initSubviews];
}

- (void)setEditable:(BOOL)editable {
    self.userInteractionEnabled = editable;
}

- (BOOL)editable {
    return self.userInteractionEnabled;
}

@end