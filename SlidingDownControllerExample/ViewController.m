//
//  ViewController.m
//  SlidingDownControllerExample
//
//  Created by Valerio Donfrancesco on 20/07/15.
//  Copyright (c) 2015 Valerio Donfrancesco. All rights reserved.
//

#import "ViewController.h"
#import "SlidingDownController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.slidingController slideButtonTapped:self];
}

@end
