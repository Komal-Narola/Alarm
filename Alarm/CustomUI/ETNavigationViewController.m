//
//  ETNavigationViewController.m
//  Passenger
//
//  Created by apple on 13-2-1.
//  Copyright (c) 2013年 qin rui. All rights reserved.
//

#import "ETNavigationViewController.h"
#import "UIColor+String.h"
NSString *const kETNavigationControllerBack = @"kETNavigationControllerBack";

@interface ETNavigationViewController ()

@end

@implementation ETNavigationViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navtop.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.tintColor = [UIColor colorWithHexString:@"#C61111"];
        self.needBack = YES;
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    UIImage *image=[UIImage imageNamed:@"naviLine.png"];
    UIImageView *lineImageView=[[UIImageView alloc]initWithImage:image];
    lineImageView.frame=CGRectMake(0, 43, image.size.width ,image.size.height);
    [self.navigationBar addSubview:lineImageView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIBarButtonItem *)createBackButton
{
    UIImage *image          = [UIImage imageNamed:@"backButton.png"];
//    UIImage *imageh         = [UIImage imageNamed:@"backh.png"];
    CGRect backframe        = CGRectMake(0, 0, 44, 44);
    UIButton* backButton    = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame        = backframe;
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
//    [backButton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem *backBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return backBarButtonItem;
}


-(UIBarButtonItem *)createHomeButton
{
    UIImage* image          = [UIImage imageNamed:@"home.png"];
    UIImage *imageh         = [UIImage imageNamed:@"homeh.png"];
//    UIImage *image          = [UIImage imageNamed:@"back.png"];
//    UIImage *imageh         = [UIImage imageNamed:@"backh.png"];
    CGRect backframe        = CGRectMake(0, 0, 44, 44);
    UIButton* backButton    = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame        = backframe;
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    //[backButton setTitle:@"首页" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem *homeBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return homeBarButtonItem;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    _viewController = viewController;
    
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 2)
    {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
    }
    
//    if ([self.viewControllers count] > 2)
//    {
//        viewController.navigationItem.rightBarButtonItem = [self createHomeButton];
//    }

}

#pragma mark -
#pragma mark btn action

-(void)popself
{
    if (self.needBack)
    {
        [self popViewControllerAnimated:YES];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kETNavigationControllerBack
                                                            object:nil
                                                          userInfo:nil];
    }
}

- (void)backToHome
{
    [self popToRootViewControllerAnimated:YES];
}



@end
