//
//  YELHeadquartersAlarmTrendViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELHeadquartersAlarmTrendViewController.h"
#import "YELPopView.h"
#import "TSPopoverController.h"

@interface YELHeadquartersAlarmTrendViewController ()
{
    NSString *domain;
    NSString *level;
    NSArray *dataSource;
    YELPopView *dominPopView;
    YELPopView *levelPopView;
    TSPopoverController *popoverController;
    NSMutableArray* greenArray;
    NSMutableArray* redArray;
    NSMutableArray* blueArray;

}
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *dominButton;
@property (weak, nonatomic) IBOutlet UIButton *levelButton;
- (IBAction)pressDominButton:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)thisMonthButton:(UIButton *)sender;
- (IBAction)preMonthButton:(UIButton *)sender;
- (IBAction)preYearButton:(UIButton *)sender;

@end

@implementation YELHeadquartersAlarmTrendViewController

NSString *const kGreenLine  = @"Green Line";
NSString *const kRedLine  = @"Red Line";
NSString *const kBlueLine = @"Blue Line";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.title=@"总部告警趋势";
        domain=@"001";
        level=@"4";

    }
    return self;
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                        domain,@"domain",
                        level,@"level",
                        TOKEN,@"token",
                        nil];
    [[YELHttpHelper defaultHelper]getTrendWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0)
        {
            NSArray *array=[dictionary objectForKey:@"data"];
            greenArray =[[NSMutableArray alloc]init];
            redArray =[[NSMutableArray alloc]init];
            blueArray =[[NSMutableArray alloc]init];
            int bigNum=0;
            for ( int i=0; i<[array count]; i++) {
                NSString *cm=[[array objectAtIndex:i]objectForKey:@"CM"];
                NSString *lcm=[[array objectAtIndex:i]objectForKey:@"LCM"];
                NSString *lm=[[array objectAtIndex:i]objectForKey:@"LM"];
                bigNum=MAX(MAX(MAX(bigNum, [cm intValue]), [lcm intValue]), [lm intValue]);
                NSString *timeorder=[[array objectAtIndex:i]objectForKey:@"TIMEORDER"];
                NSDictionary *greenDict=[NSDictionary dictionaryWithObjectsAndKeys:cm,@"y",timeorder,@"x", nil];
                NSDictionary *redDict=[NSDictionary dictionaryWithObjectsAndKeys:lcm,@"y",timeorder,@"x", nil];
                NSDictionary *blueDict=[NSDictionary dictionaryWithObjectsAndKeys:lm,@"y",timeorder,@"x", nil];
                [greenArray addObject:greenDict];
                [redArray addObject:redDict];
                [blueArray addObject:blueDict];
            }
            [self getasix:bigNum];
        }
        else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg)
    {
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        
    }];

}
-(void)getasix :(int)bigNum
{
    [graph reloadData];
    bigNum = bigNum + bigNum*0.1;
//    CPTXYPlotSpace *plotSpace =(CPTXYPlotSpace *)graph.defaultPlotSpace;
    CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace *)[graph plotSpaceAtIndex:1];
    plotSpace.yRange =[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)length:CPTDecimalFromFloat(bigNum)];
    CPTXYAxisSet*axisSet = (CPTXYAxisSet *)graph.axisSet; //1
    CPTXYAxis *x= axisSet.xAxis; 
    x.majorIntervalLength=CPTDecimalFromInt(5);
    CPTXYAxis *y   = axisSet.yAxis;
    int dian=bigNum/10;
    y.majorIntervalLength=CPTDecimalFromInt(dian); 
    
   
}
-(void)trendgraph
{
    graph = [[CPTXYGraph alloc]initWithFrame:CGRectZero];
    CPTTheme *theme=[CPTTheme themeNamed:kCPTDarkGradientTheme];
    [graph applyTheme:theme];
    float height=[UIScreen mainScreen].applicationFrame.size.height;
    CPTGraphHostingView *hostingView=[[CPTGraphHostingView alloc]initWithFrame:CGRectMake(0, 30, 320, height-88-30)];
    hostingView.hostedGraph=graph;
    hostingView.allowPinchScaling=NO;
    hostingView.collapsesLayers=NO;
    [self.view addSubview:hostingView];
    graph.paddingLeft=0;
    graph.paddingRight=0;
    graph.paddingTop=0;
    graph.paddingBottom=0;
    graph.plotAreaFrame.paddingLeft = 50 ;
    graph.plotAreaFrame.paddingTop = 10.0 ;
//    graph.plotAreaFrame.paddingRight = 20.0 ;
    graph.plotAreaFrame.paddingBottom = 25.0 ;

    CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(1) length:CPTDecimalFromInt(31)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(100)];
    
    NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init] ;
    labelFormatter.maximumFractionDigits = 0;

    CPTXYAxisSet*axisSet = (CPTXYAxisSet *)graph.axisSet; 
    CPTXYAxis*x   = axisSet.xAxis;
    x.majorIntervalLength=CPTDecimalFromInt(5);
    x. minorTickLineStyle = nil ;
    x.orthogonalCoordinateDecimal= CPTDecimalFromString(@"1"); 
    x.labelFormatter=labelFormatter;

    CPTXYAxis *y   = axisSet.yAxis; 
    y.majorIntervalLength=CPTDecimalFromString(@"10"); 
    y.orthogonalCoordinateDecimal= CPTDecimalFromString(@"0"); 
    y. minorTickLineStyle = nil ;
    y.labelFormatter=labelFormatter;
    
    CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init] ;
    CPTMutableLineStyle*lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth = 1.0f;
    lineStyle.lineColor = [CPTColor blueColor];
    boundLinePlot.dataLineStyle= lineStyle;
    boundLinePlot.identifier = kBlueLine;
    boundLinePlot.dataSource = self;
    [graph addPlot:boundLinePlot];
    
    CPTScatterPlot *greenLinePlot  = [[CPTScatterPlot alloc] init] ;
    CPTMutableLineStyle*greenlineStyle = [CPTMutableLineStyle lineStyle];
    //    redlineStyle.miterLimit = 1.0f;
    greenlineStyle.lineWidth = 1.0f;
    greenlineStyle.lineColor = [CPTColor greenColor];
    greenLinePlot.dataLineStyle= greenlineStyle;
    greenLinePlot.identifier = kGreenLine;
    greenLinePlot.dataSource = self;
    [graph addPlot:greenLinePlot];
    
    CPTScatterPlot *redLinePlot  = [[CPTScatterPlot alloc] init] ;
    CPTMutableLineStyle*redlineStyle = [CPTMutableLineStyle lineStyle];
    //    redlineStyle.miterLimit = 1.0f;
    redlineStyle.lineWidth = 1.0f;
    redlineStyle.lineColor = [CPTColor redColor];
    redLinePlot.dataLineStyle= redlineStyle;
    redLinePlot.identifier = kRedLine;
    redLinePlot.dataSource = self;
    [graph addPlot:redLinePlot];

}
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot*)plot

{
    if ([(NSString *)plot.identifier isEqualToString:kGreenLine]) {
        return [greenArray count];
    }else if ([(NSString *)plot.identifier isEqualToString:kRedLine])
    {
        return[redArray count];
    }else{
        return [blueArray count];
    }
}
-(NSNumber*)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index

{
    NSNumber *number;
    switch ( fieldEnum ) {
        case CPTScatterPlotFieldX:
            if ( plot.identifier == kGreenLine ) {
                
                number =[[greenArray objectAtIndex:index] valueForKey:@"x"];
            }
            else if(plot.identifier == kRedLine){
                number =[[redArray objectAtIndex:index] valueForKey:@"x"];
            }else
            {
                number=[[blueArray objectAtIndex:index]valueForKey:@"x"];
            }
            break;
            
        case CPTScatterPlotFieldY:
            if ( plot.identifier == kGreenLine ) {
                number = [[greenArray objectAtIndex:index] valueForKey:@"y"];
            }
            else if(plot.identifier == kRedLine){
                number =[[redArray objectAtIndex:index] valueForKey:@"y"];
            }else
            {
                number=[[blueArray objectAtIndex:index]valueForKey:@"y"];
            }
            break;
            //    NSString*key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
            //
            //    NSNumber*num = [[points objectAtIndex:index] valueForKey:key];
    }
    return number;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backImageView.layer setCornerRadius:5.0];
    [self trendgraph];
    [self sendRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pressDominButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!dominPopView) {
        NSArray *array=[NSArray arrayWithObjects:@"BBS域",@"MSS域",@"DSS域",@"信息化基础", nil];
        dominPopView=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 100, [array count]*30) array:array target:self];
        dominPopView.tag=200;
    }
    popoverController=[[TSPopoverController alloc]initWithView:dominPopView];
    popoverController.alpha=0.9;
    [popoverController showPopoverWithTouch:event];
}

- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!levelPopView) {
        NSArray *array=[NSArray arrayWithObjects:@"重要",@"紧急", nil];
        levelPopView=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 100, [array count]*30) array:array target:self];
        levelPopView.tag=201;
    }
    popoverController=[[TSPopoverController alloc]initWithView:levelPopView];
    popoverController.alpha=0.9;
    [popoverController showPopoverWithTouch:event];
}
-(void)pressButton:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        for (UIView *bt in sender.superview.subviews) {
            if ([bt isKindOfClass:[UIButton class]]) {
                UIButton *button=(UIButton *)bt;
                if (button != sender) {
                    button.selected=NO;
                }
            }
            
        }
    }
    if (sender.superview.tag==200)
    {
        if (sender.tag==100) {
            [self.dominButton setTitle:@"BSS域" forState:UIControlStateNormal];
            domain=@"001";
        }else if (sender.tag==101)
        {
            [self.dominButton setTitle:@"MSS域" forState:UIControlStateNormal];
            domain=@"002";
        }else if (sender.tag==102)
        {
            [self.dominButton setTitle:@"DSS域" forState:UIControlStateNormal];
            domain=@"003";
        }else if (sender.tag==103)
        {
            [self.dominButton setTitle:@"信息化基础" forState:UIControlStateNormal];
            domain=@"004";
        }
    }
    else if(sender.superview.tag==201)
    {
        if (sender.tag==100) {
            [self.levelButton setTitle:@"重要" forState:UIControlStateNormal];
            level=@"4";
        }else if (sender.tag==101)
        {
            [self.levelButton setTitle:@"紧急" forState:UIControlStateNormal];
            level=@"5";
        }
    }

    [self sendRequest];
    [popoverController dismissPopoverAnimatd:YES];
}
- (IBAction)thisMonthButton:(UIButton *)sender
{
    sender.selected=!sender.selected;
    CPTPlot *greenPlot=[graph plotWithIdentifier:kGreenLine];
    if (sender.selected)
    {
        greenPlot.hidden=YES;
    }
    else
    {
        greenPlot.hidden=NO;
    }
}

- (IBAction)preMonthButton:(UIButton *)sender
{
    sender.selected=!sender.selected;
    CPTPlot *redPlot=[graph plotWithIdentifier:kRedLine];
    if (sender.selected)
    {
        redPlot.hidden=YES;
    }
    else
    {
        redPlot.hidden=NO;
    }
}

- (IBAction)preYearButton:(UIButton *)sender
{
    sender.selected=!sender.selected;
    CPTPlot *bluePlot=[graph plotWithIdentifier:kBlueLine];
    if (sender.selected)
    {
        bluePlot.hidden=YES;
    }
    else
    {
        bluePlot.hidden=NO;
    }
}
- (void)viewDidUnload {
    [self setDominButton:nil];
    [self setLevelButton:nil];
    [self setBackImageView:nil];
    [super viewDidUnload];
}

-(int)yTotal : (NSMutableArray *)array
{
    int sum=0;
    for (int i=0; i<[array count]; i++) {
        sum +=[[[array objectAtIndex:i]objectForKey:@"y" ] intValue];
    }
    return sum;
}
@end
