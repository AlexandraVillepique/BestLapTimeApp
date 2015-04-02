//
//  StopWatch.h
//  StopWatch
//
//  Created by Aleksandra Villepique on 2/4/15.
//  Copyright (c) 2015 Villepique. All rights reserved.
//

#import <Foundation/Foundation.h>

//declaring the class - we use this name for the object type.
@class StopWatch;

//establishing communication standard between this code file and other code files.
@protocol StopWatchDelegate <NSObject>
//required methods
-(void) stopWatchDidUpdate:(StopWatch *)stopWatch;

@optional
//optional methods

@end

@interface StopWatch : NSObject{
    int lap;
    float lapBestInterval;
}

@property (readonly,nonatomic, strong) NSDate * startDate;
@property (readonly, nonatomic, strong) NSDate * stopDate;


//any object that needs to confirm to the StopWatchDelegate. ID means any object.
@property (nonatomic,weak) id<StopWatchDelegate> delegate;

//always do copy with the string
@property (nonatomic, copy) NSString *dateFormatString;
//@property (nonatomic, copy) NSString *lapFormatString;


-(void)startTimer;
-(void)stopTimer;
-(void)resetTimer;
-(void)countLap;
-(void)findBestLapTime;

-(NSString *)formatTimeInterval:(NSTimeInterval)timeInterval;
-(NSTimeInterval)duration;
-(NSString *)lapString;
-(NSString *)lapTimeString;

@end
