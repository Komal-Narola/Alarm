//
//  YELMainControllerViewController.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELMainControllerViewController.h"
#import "YELSettingControllerViewController.h"
#import "UIImageView+WebCache.h"
#import "StyledPageControl.h"
@interface YELMainControllerViewController ()
{
    UIScrollView *topScrollView;
    UIScrollView *bottomScrollView;
    StyledPageControl *pageControl;
}
@end

@implementation YELMainControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"IT服务支撑平台";
        self.navigationItem.rightBarButtonItem=[self createHomeButton];
        self.navigationItem.hidesBackButton=YES;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
    if (token!=nil) {
        NSDictionary *dict=[NSDictionary dictionaryWithObject:token forKey:@"token"];
        [[YELHttpHelper defaultHelper]getImageWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [self initTopScrollView:[array count]];
                for (int i=0; i<[array count]; i++) {
                    NSString *path=[[array objectAtIndex:i]objectForKey:@"URI"];
                    NSString *url=[APIURL stringByAppendingString:path];
                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 120)];
                    [imageView setImageWithURL:[NSURL URLWithString:url]];
                    if (i==0) {
                        [imageView setBackgroundColor:[UIColor blueColor]];
                    }else if (i==1)
                    {
                        [imageView setBackgroundColor:[UIColor redColor]];
                    }else
                    {
                        [imageView setBackgroundColor:[UIColor yellowColor]];
                    }
                    
                    [topScrollView addSubview:imageView];
                }
            }
            
        } falid:^(NSString *errorMsg) {
            
        }];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)initTopScrollView:(int)count
{
    topScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    topScrollView.pagingEnabled=YES;
    topScrollView.delegate=self;
    [topScrollView setContentSize:CGSizeMake(320*count, 120)];
    [topScrollView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:topScrollView];
    //pageControl
    pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(136, 103, 50, 15)];
    [pageControl setPageControlStyle:PageControlStyleThumb];
    [pageControl setThumbImage:[UIImage imageNamed:@"pagecontrol-thumb-normal.png"]];
    [pageControl setSelectedThumbImage:[UIImage imageNamed:@"pagecontrol-thumb-selected.png"]];
    [pageControl setNumberOfPages:count];
    [self.view addSubview:pageControl];
}
- (void)changePage:(id)sender
{
    int page = pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect frame = topScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [topScrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
//    pageControlUsed = YES;
}

-(void)initUiKit
{

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)setController
{
    YELSettingControllerViewController *setController=[[YELSettingControllerViewController alloc]initWithNibName:@"YELSettingControllerViewController" bundle:nil];
    [self.navigationController pushViewController:setController animated:YES];
}
-(UIBarButtonItem *)createHomeButton
{
    UIImage* image          = [UIImage imageNamed:@"set.png"];
//   UIImage *imageh        = [UIImage imageNamed:@"homeh.png"];
    CGRect backframe        = CGRectMake(0, 0, 44, 44);
    UIButton* setButton     = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame         = backframe;
    [setButton setImage:image forState:UIControlStateNormal];
//   [backButton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    [setButton addTarget:self action:@selector(setController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:setButton];
    return rightBarButtonItem;
}
- (void)viewDidUnload {
    topScrollView=nil;
    bottomScrollView=nil;
    [super viewDidUnload];
}
#pragma mark Scorllview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender==topScrollView) {
        CGFloat pageWidth = sender.frame.size.width;
        int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
    }

}

@end
