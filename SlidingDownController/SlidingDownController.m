//
//  SlidingDownController.m
//  SlidingDownController
//
//  Created by Valerio Donfrancesco on 20/07/15.
//  Copyright (c) 2015 Valerio Donfrancesco. All rights reserved.
//

#import "SlidingDownController.h"
#import "UIViewController+SlidingDownController.h"

@interface SlidingDownController ()

@end

@implementation SlidingDownController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    }
    
    return self;
}


- (void) slideDown {
    
    [self slideDownWithCompletion:nil];
}


- (void) slideDownWithCompletion:(SlidingDownControllerDefaultHandler) completion {
    
    
    
}

- (void) slideUp {
    
    
}

- (void) slideUpWithCompletion:(SlidingDownControllerDefaultHandler) completion {
    
    
}



@end
