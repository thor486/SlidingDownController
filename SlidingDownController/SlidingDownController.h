//
//  SlidingDownController.h
//  SlidingDownController
//
//  Created by Valerio Donfrancesco on 19/07/15.
//  Copyright (c) 2015 Valerio Donfrancesco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SlidingDownController.h"

typedef enum : NSUInteger
{
    SlidingDownControllerDown     = 1,
    SlidingDownControllerUp       = 2,
    SlidingDownControllerDefault  = 3
} SlidingDownControllerState;

//! Project version number for SlidingDownController.
FOUNDATION_EXPORT double SlidingDownControllerVersionNumber;

//! Project version string for SlidingDownController.
FOUNDATION_EXPORT const unsigned char SlidingDownControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SlidingDownController/PublicHeader.h>

@interface SlidingDownController : UIViewController

typedef void(^SlidingDownControllerDefaultHandler)(BOOL finished);

@property (nonatomic, readwrite) UIViewController *frontViewController;
@property (nonatomic, readwrite) UIViewController *backViewController;
@property (nonatomic, assign) SlidingDownControllerState slidingControllerState;
@property (nonatomic, assign) CGFloat bottomOffset;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) BOOL recognizesPanningOnFrontView;
@property (nonatomic, readonly) UIPanGestureRecognizer *slidingPanGestureRecognizer;
@property (nonatomic, readonly) UITapGestureRecognizer *slidingTapGestureRecognizer;

+ (instancetype) slidingDownControllerWithFrontController:(UIViewController *) frontController
                                           backController:(UIViewController *) backController;

- (IBAction) slideButtonTapped:(id)sender;

- (void) slideDown;
- (void) slideUp;
- (void) slideDownWithCompletion:(SlidingDownControllerDefaultHandler) completion;
- (void) slideUpWithCompletion:(SlidingDownControllerDefaultHandler) completion;

@end
