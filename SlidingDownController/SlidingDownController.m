//
//  SlidingDownController.m
//  SlidingDownController
//
//  Created by Valerio Donfrancesco on 20/07/15.
//  Copyright (c) 2015 Valerio Donfrancesco. All rights reserved.
//

#import "SlidingDownController.h"

@interface SlidingDownController ()

@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *slidingPanGestureRecognizer;

@end

@implementation SlidingDownController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupContainerViews];
    [self setupGestureRecognizers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype) slidingDownControllerWithFrontController:(UIViewController *) frontController
                                           backController:(UIViewController *) backController {
    
    return [[[self class] alloc] initWithFrontViewController:frontController backController:backController];
}


- (instancetype) initWithFrontViewController:(UIViewController *) frontController
                              backController:(UIViewController *) backController {
    
    self = [super init];
    
    if (self)  {
        
        _frontViewController = frontController;
        _backViewController = backController;
        
        _frontViewController.slidingController = self;
        _backViewController.slidingController = self;
        
        [self loadDefaultValues];
    }
    
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self)
    {
        [self loadDefaultValues];
    }
    
    return self;
}


- (void) slideDown {
    
    [self slideDownWithCompletion:nil];
}


- (void)updatePanGestureRecognizerPresence
{
    if (self.recognizesPanningOnFrontView)
    {
        if (![self.frontView.gestureRecognizers containsObject:self.slidingPanGestureRecognizer])
        {
            [self.frontView addGestureRecognizer:self.slidingPanGestureRecognizer];
        }
    }
    else
    {
        if ([self.frontView.gestureRecognizers containsObject:self.slidingPanGestureRecognizer])
        {
            [self.frontView removeGestureRecognizer:self.slidingPanGestureRecognizer];
        }
    }
}

- (void)setupGestureRecognizers
{
    self.slidingPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(didRecognizePanGesture:)];
    
    self.slidingPanGestureRecognizer.maximumNumberOfTouches = 1;
    
    [self updatePanGestureRecognizerPresence];
}

- (void) didRecognizePanGesture:(UIPanGestureRecognizer *) recognizer {
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
        }
            break;
            
        default:
            break;
    }
}


- (void) slideDownWithCompletion:(SlidingDownControllerDefaultHandler) completion {
    
    [self addViewController:self.backViewController container:self.backView];
    self.backView.hidden = false;
    [UIView animateWithDuration:1.0 animations:^{
        
        _frontViewController.view.frame = CGRectOffset(_frontViewController.view.frame, 0, [UIScreen mainScreen].bounds.size.height - _bottomOffset);
        
    } completion:^(BOOL finished) {
        
        _slidingControllerState = SlidingDownControllerDown;
        
        if (completion != nil)
            completion(true);
    }];
}

- (void) slideUp {
    
    [self slideUpWithCompletion:nil];
}

- (void) slideUpWithCompletion:(SlidingDownControllerDefaultHandler) completion {
    
    [UIView animateWithDuration:1.0 animations:^{
        
        _frontViewController.view.frame = CGRectOffset(_frontViewController.view.frame, 0, -([UIScreen mainScreen].bounds.size.height - _bottomOffset));
        
    } completion:^(BOOL finished) {
        
        self.backView.hidden = true;
        _slidingControllerState = SlidingDownControllerUp;
        if (completion != nil)
            completion(true);
    }];
}

- (BOOL)shouldAutorotate
{
    return [self.frontViewController shouldAutorotate] && [self.backViewController shouldAutorotate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.frontViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation] &&
    [self.backViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{

}

- (void) loadDefaultValues {
    
    _animationDuration = 1.0;
    _bottomOffset = 100.0;
    _slidingControllerState = SlidingDownControllerDefault;
    _recognizesPanningOnFrontView = false;
}


#pragma mark - IBActions

- (IBAction) slideButtonTapped:(id)sender {
    
    if (_slidingControllerState == SlidingDownControllerDown)
        [self slideUp];
    else if (_slidingControllerState == SlidingDownControllerUp || _slidingControllerState == SlidingDownControllerDefault)
        [self slideDown];
}

#pragma mark - View Controller Containment

- (void)setupContainerViews
{
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.frontView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    self.frontView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.backView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    self.backView.hidden = YES;
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.frontView];
    
    [self addViewController:self.frontViewController container:self.frontView];
}

- (void)addViewController:(UIViewController *)childController container:(UIView *)container
{
    if (childController &&
        ![self.childViewControllers containsObject:childController])
    {
        [self addChildViewController:childController];
        childController.view.frame = container.bounds;
        childController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        childController.slidingController = self;
        [container addSubview:childController.view];
        [self didMoveToParentViewController:self];
    }
}

- (void)removeViewController:(UIViewController *)childController
{
    if (childController && [self.childViewControllers containsObject:childController])
    {
        [childController willMoveToParentViewController:nil];
        [childController.view removeFromSuperview];
        [childController removeFromParentViewController];
        childController.slidingController = nil;
    }
}


@end
