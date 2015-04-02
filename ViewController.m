//
//  ViewController.m
//  StopWatch
//
//  Created by Aleksandra Villepique on 1/12/15.
//  Copyright (c) 2015 Villepique. All rights reserved.
//

#import "ViewController.h"
#import "StopWatch.h"
#import <iAd/iAd.h> 

//we're saying that we're conforming to the communication protocol

@interface ViewController ()<StopWatchDelegate>{
    StopWatch * stopWatch;
    
}

@property (weak, nonatomic) IBOutlet UILabel *mainTimer;
@property (weak, nonatomic) IBOutlet UILabel *averageLapTimer;
@property (weak, nonatomic) IBOutlet UILabel *numberLap;
@property (weak, nonatomic) IBOutlet UILabel *bestLapTime;


@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTimer.text = @"00:00:00.000";
    self.numberLap.text = @"0";
    self.averageLapTimer.text = @"00:00:00.000";
    //setting up our stopwathc. This is a hook for view control operation
    stopWatch = [[StopWatch alloc] init];
    stopWatch.delegate = self;
    
    [stopWatch resetTimer];

    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime: (NSTimer *)timer {
   // [self updateDisplayTime];
}

- (void)startTimer{
    [stopWatch startTimer];
}

- (void)stopTimer{
    [stopWatch stopTimer];
    
}

- (void)resetTimer{
    [stopWatch resetTimer];
}

-(void)updateLap{
    [stopWatch countLap];
}

-(void)updateLapTime{
    [stopWatch findBestLapTime];
}

- (IBAction)stopTime:(UIButton *)sender {
    [self stopTimer];
    
}

- (IBAction)markLap:(UIButton *)sender {
    [self updateLap];
    [self updateLapTime];
    //
   // self.numberLap.text=lapString;
    //calculation of average lap time
 //
    
//    self.averageLapTimer.text= [self formatTimeInterval:lapBestInterval];
    
}



- (IBAction)startTime:(UIButton *)sender {
    [self startTimer];
}
- (IBAction)resetTime:(UIButton *)sender {
    [self resetTimer];
}

#pragma mark - StopWatchDelegate

-(void)stopWatchDidUpdate:(StopWatch *)stopWatch{

    NSTimeInterval duration = [stopWatch duration];
    self.mainTimer.text = [stopWatch formatTimeInterval:duration];
    
    self.numberLap.text = [stopWatch lapString];
    
  //  self.averageLapTimer.text =
    NSString * test = [stopWatch lapTimeString];
    self.averageLapTimer.text = test;
    
}

@end
