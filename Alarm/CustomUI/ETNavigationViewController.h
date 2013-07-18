//
//  ETNavigationViewController.h
//  Passenger
//
//  Created by apple on 13-2-1.
//  Copyright (c) 2013年 qin rui. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kETNavigationControllerBack;

@interface ETNavigationViewController : UINavigationController
{
    UIViewController *_viewController;
}

@property (nonatomic, assign) BOOL needBack;

@end
