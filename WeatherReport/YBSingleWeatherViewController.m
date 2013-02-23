//
//  YBSingleWeatherViewController.m
//  WeatherReport
//
//  Created by yibin on 13-2-22.
//  Copyright (c) 2013年 us.yibin. All rights reserved.
//

#import "YBSingleWeatherViewController.h"
#import "YBWeatherQuery.h"
@interface YBSingleWeatherViewController ()
{
    UIActivityIndicatorView *loadding;
}
@end
@implementation YBSingleWeatherViewController
@synthesize lblCityName = _lblCityName;
@synthesize lblDateWeek = _lblDateWeek;
@synthesize lblWeather = _lblWeather;
@synthesize lblTemp = _lblTemp;
@synthesize lblCurrTemp = _lblCurrTemp;
@synthesize lblSD = _lblSD;
@synthesize lblLastUpdate = _lblLastUpdate;
@synthesize city = _city;
@synthesize btnUpdate = _btnUpdate;
@synthesize imgBackground = _imgBackground;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)Bind{
    self.imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
   
    
    YBWeatherQuery *query = [[YBWeatherQuery alloc] initWithCityCode:self.city[@"citycode"]];
    NSDictionary *weather_info = [query QueryWeather];
    self.lblDateWeek.text= [NSString stringWithFormat:@"%@ %@", weather_info[@"all"][@"date_y"],weather_info[@"all"][@"week"]];
    self.lblWeather.text=[NSString stringWithFormat:@"%@ %@%@",weather_info[@"sk2"][@"weather"], weather_info[@"sk"][@"WD"],weather_info[@"sk"][@"WS"]];
    
    
    
    int min = MIN([weather_info[@"sk2"][@"temp1"] intValue], [weather_info[@"sk2"][@"temp2"] intValue]);
    int max = MAX([weather_info[@"sk2"][@"temp1"] intValue], [weather_info[@"sk2"][@"temp2"] intValue]);
    self.lblTemp.text= [NSString stringWithFormat:@"最低气温:%d,最高气温:%d",min,max];
    self.lblCurrTemp.text=weather_info[@"sk"][@"temp"];
    
    self.lblCityName.text = [NSString stringWithFormat:@"%@",self.city[@"cityname"]];
    self.lblSD.text = [NSString stringWithFormat:@"湿度:%@" ,weather_info[@"sk"][@"SD"]];

    self.lblLastUpdate.text = [NSString stringWithFormat:@"更新于%@ %@",weather_info[@"all"][@"date_y"], weather_info[@"sk"][@"time"]];
    self.lblLastUpdate.frame = CGRectMake(40, self.view.frame.size.height-30, 300, 20);
    self.lblLastUpdate.textAlignment = NSTextAlignmentLeft;
    

    self.btnUpdate.frame = CGRectMake(10, self.view.frame.size.height-30, 20, 20);
    self.btnUpdate.backgroundColor = [UIColor clearColor];
    
    //EXC_BAD_ACCESS
    [self.btnUpdate addTarget:self action:@selector(ReLoadBind::) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.btnUpdate];
        
    
    
    CGRect rect = self.view.frame;
    NSLog(@"%f",rect.size.height);
    rect.size.width-=10;
    rect.size.height-=40;
    rect.origin.x = 5;
    rect.origin.y = 5;
    self.imgBackground.frame = rect;
    
    
    [self.view insertSubview:self.imgBackground atIndex:0];
    
    [loadding stopAnimating];
}

-(IBAction)ReLoadBind:(id)sender{
    NSLog(@"refersh");
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    loadding = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   
    loadding.frame = CGRectMake(10, self.view.frame.size.height-30, 20, 20);
    self.lblLastUpdate.text=@"正在更新......";
    [loadding startAnimating];
    [self.view addSubview:loadding];
      [self performSelectorInBackground:@selector(Bind) withObject:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidUnload {
    [self setLblCityName:nil];
    [self setLblDateWeek:nil];
    [self setLblWeather:nil];
    [self setLblTemp:nil];
    [self setLblCurrTemp:nil];
    [self setLblSD:nil];
    [self setLblLastUpdate:nil];
    [self setBtnUpdate:nil];
    [self setImgBackground:nil];
    [super viewDidUnload];
}
@end
