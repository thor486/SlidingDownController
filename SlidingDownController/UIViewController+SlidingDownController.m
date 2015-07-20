//
//  ViewController+SlidingDownController.m
//  
//
//  Created by Valerio Donfrancesco on 20/07/15.
//
//

#import "UIViewController+SlidingDownController.h"
#import "SlidingDownController.h"
#import <objc/runtime.h>

@implementation UIViewController (SlidingDownController)

static char slidingControllerKey;

- (void)setSlidingController:(SlidingDownController *)slidingController
{
    objc_setAssociatedObject(self, &slidingControllerKey, slidingController, OBJC_ASSOCIATION_ASSIGN);
}

- (SlidingDownController *)slidingController
{
    
    SlidingDownController *controller = (SlidingDownController *)objc_getAssociatedObject(self,&slidingControllerKey);
    
    if (!controller)
    {
        if (self.parentViewController)
        {
            return [self.parentViewController slidingController];
        }
        
        return nil;
    }
    
    return controller;
}

@end
