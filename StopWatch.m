//
//  StopWatch.m
//  StopWatch
//
//  Created by Aleksandra Villepique on 2/4/15.
//  Copyright (c) 2015 Villepique. All rights reserved.
//

#import "StopWatch.h"

@interface StopWatch(){
    NSTimer *myTimer;
    NSDate *lapDate2;
    NSDate * currentDate;
    NSString *bestIntervalString;
}

@end

@implementation StopWatch

//create custom initialiser.

-(id)init{
    self = [super init];
    if (self){
        _dateFormatString=@"HH:mm:ss.SSS";
        //default format, if no one sets it.
    }
    return self;
}

- (void)updateTime: (NSTimer *)timer {
    currentDate = [NSDate date];
    
    [self updateStopWatch];
}

- (void)startTimer{
    //check is the timer already running
    if(!myTimer){
        //timer fires every second
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    }
    //store a start date
    if (!_startDate && _stopDate){
        _startDate = [NSDate date];
    }else{
        //resume
        NSTimeInterval duration = [_stopDate timeIntervalSinceDate:_startDate];
        _startDate=[NSDate dateWithTimeInterval:-duration sinceDate:[NSDate date]];
    }
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm:ss.SSS"];
    NSString *startDateString = [dateFormater stringFromDate:_startDate];
    
    NSLog(@"Start: %@", startDateString);
    
}

- (void)stopTimer{
    if (myTimer){
        [myTimer invalidate];
        myTimer = nil;
    
        //store a stop date
        _stopDate = [NSDate date];
    
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"HH:mm:ss.SSS"];
        NSString *stopDateString = [dateFormater stringFromDate:_stopDate];
    
        NSLog(@"Stop: %@", stopDateString);
    
    }
}

- (void)resetTimer{
    [self stopTimer];
    _stopDate=nil;
    _startDate=nil;
    currentDate=nil;
    
    lap=0;
    lapBestInterval = 50000.0;
   
    [self updateStopWatch];
}


- (void)updateStopWatch{
    
    NSDate * currentDate = [NSDate date];
    
    NSTimeInterval elapsedTime = [currentDate timeIntervalSinceDate:_startDate];
    
    NSString *stopWatchString =[self formatTimeInterval:elapsedTime];
    NSString *lapString = [NSString stringWithFormat:@"%d",lap ];
    bestIntervalString = @"00:00:00.000";
    if (lap != 0){
        bestIntervalString =[self formatTimeInterval:lapBestInterval];
    }
    //use of the custom defined protocol and class - this works for multiple timers
    [self.delegate stopWatchDidUpdate:self];
    
}

-(NSString *)formatTimeInterval:(NSTimeInterval)timeInterval{
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  //  [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setDateFormat:_dateFormatString];

    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    
    return timeString;
}


-(NSString *)lapString{
    
    NSString *formatedLapString=[NSString stringWithFormat:@"%d",lap];
    
    return formatedLapString;
}


-(NSString *)lapTimeString{
    
    NSString * formatedLapTimeString = bestIntervalString;
    
    return formatedLapTimeString;
}

-(void)countLap{
    
   if (_startDate){
        lap++;
        
    }
    
    [self updateStopWatch];
}



-(void)findBestLapTime{
    NSDate *lapDate = [NSDate date];
       if(lap==1){
           NSTimeInterval lapInterval = [lapDate timeIntervalSinceDate:_startDate];
          lapDate2 = lapDate;
           lapBestInterval= lapInterval;
    
       }else{
           NSTimeInterval lapInterval = [lapDate timeIntervalSinceDate:lapDate2];
           if(lapBestInterval>lapInterval){lapBestInterval=lapInterval;}
           lapDate2=lapDate;
       }

    [self updateStopWatch];
    
}


-(NSTimeInterval)duration {
    
    NSTimeInterval elapsedTime = 0;
    
    if (currentDate && _startDate){
    
        elapsedTime = [currentDate timeIntervalSinceDate:_startDate];
    
    }
    return elapsedTime;

}



@end
