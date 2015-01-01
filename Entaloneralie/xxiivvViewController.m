//
//  xxiivvViewController.m
//  Entaloneralie
//
//  Created by Devine Lu Linvega on 2013-06-01.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

AVAudioPlayer *audioPlayerSounds;

int timeMode = 0;

@interface xxiivvViewController ()

@property (strong, nonatomic) IBOutlet UIButton *modeToggleButton;
@property (strong, nonatomic) IBOutlet UILabel *modeLabel;

@end

@implementation xxiivvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) start
{
	NSLog(@"!");
	[self tmplStart];
	[self timeStart];
	[self timeUpdate];
}

- (void) tmplStart
{
	screen = [[UIScreen mainScreen] bounds];
	float screenWidth = screen.size.width;
	float screenHeight = screen.size.height;
	float tileSize = screen.size.width/8;
	
	self.wrapperView.backgroundColor = [UIColor blackColor];
	
	self.wrapperView.frame = CGRectMake(tileSize, tileSize, screenWidth-(2*tileSize), screenHeight-(2*tileSize));
	
	self.borderLeftView.backgroundColor = [UIColor whiteColor];
	self.borderLeftView.frame = CGRectMake(0, 0, 1, self.wrapperView.frame.size.height);
	self.borderRightView.backgroundColor = [UIColor whiteColor];
	self.borderRightView.frame = CGRectMake(self.wrapperView.frame.size.width-1, 0, 1, self.wrapperView.frame.size.height);
	self.borderTopView.backgroundColor = [UIColor whiteColor];
	self.borderTopView.frame = CGRectMake(0, 0, self.wrapperView.frame.size.width, 1);
	self.borderBottomView.backgroundColor = [UIColor whiteColor];
	self.borderBottomView.frame = CGRectMake(0, self.wrapperView.frame.size.height-1, self.wrapperView.frame.size.width, 1);
	
	self.modeToggleButton.frame = CGRectMake(0, 0, screenWidth, screenHeight);
	self.modeLabel.frame = CGRectMake(tileSize, tileSize, screenWidth-(2*tileSize), screenHeight-(2*tileSize));
	self.modeLabel.backgroundColor = [UIColor whiteColor];
	self.modeLabel.textColor = [UIColor blackColor];
	self.modeLabel.alpha = 0;
}

- (void) timeStart
{
	NSLog(@"Time: Start");
	[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES];
}

- (IBAction)modeToggleButton:(id)sender
{
	self.modeLabel.alpha = 1;
	[self fadeOut:self.modeLabel d:0 t:0.5];
	
	timeMode += 1;
	if( timeMode > 2 ){
		timeMode = 0;
	}
	
	[self audioPlayerSounds:@"sounds.click.mp3"];
}

- (void) timeUpdate
{
	screen = [[UIScreen mainScreen] bounds];
	float screenWidth = screen.size.width;
	float screenHeight = screen.size.height;
	float tileSize = screen.size.width/8;
	float wrapperWidth = self.wrapperView.frame.size.width;
	float wrapperHeight = self.wrapperView.frame.size.height;
	
	// Seconds in a day : 86400
	
	NSDate *currentTime = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"HH"]; // @"hh-mm"
	int t_hour = [[dateFormatter stringFromDate: currentTime] intValue];
	
	[dateFormatter setDateFormat:@"mm"]; // @"hh-mm"
	int t_minu = [[dateFormatter stringFromDate: currentTime] intValue];
	
	[dateFormatter setDateFormat:@"ss"]; // @"hh-mm"
	int t_seco = [[dateFormatter stringFromDate: currentTime] intValue];
	
	[dateFormatter setDateFormat:@"SSS"]; // @"hh-mm"
	int t_milli = [[dateFormatter stringFromDate: currentTime] intValue];
	
	float secondsInDay = 86400;
	float secondsPast = t_seco + (60*t_minu) + (t_hour*60*60);
	
	if( timeMode == 0 ){
		// Minutes
		secondsInDay = 60000;
		secondsPast = (t_seco * 1000) + t_milli;
	}
	else if( timeMode == 1 ){
		// Hour
		secondsInDay = 3600000;
		secondsPast = (t_minu * 60 * 1000) + (t_seco * 1000) + t_milli;
	}
	else{
		// 12 hours format
		secondsInDay = 86400/2;
		secondsPast = t_seco + (60*t_minu) + ((t_hour % 12)*60*60);
	}

	float perc1 = (int)((secondsPast/secondsInDay) * 1000);
	float perc2 = (int)((secondsPast/(secondsInDay/2)) *1000) % 1000;
	float perc3 = (int)((secondsPast/(secondsInDay/4)) *1000) % 1000;
	float perc4 = (int)((secondsPast/(secondsInDay/8)) *1000) % 1000;
	float perc5 = (int)((secondsPast/(secondsInDay/16)) *1000) % 1000;
	float perc6 = (int)((secondsPast/(secondsInDay/32)) *1000) % 1000;
	float perc7 = (int)((secondsPast/(secondsInDay/64)) *1000) % 1000;
	float perc8 = (int)((secondsPast/(secondsInDay/128)) *1000) % 1000;
	float perc9 = (int)((secondsPast/(secondsInDay/256)) *1000) % 1000;
	
//	NSLog(@"%f : %f : %f : %f : %f : %f : %f : %f : %f",perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8,perc9 );
	
	float ratio1PosY = (perc1/1000)*wrapperHeight;
	self.ratio1View.backgroundColor = [UIColor whiteColor];
	self.ratio1View.frame = CGRectMake(0,(int)ratio1PosY , wrapperWidth, 1);
	
	self.ratio1Label.frame = CGRectMake(tileSize*-1, ratio1PosY-(tileSize/2), tileSize-10, tileSize);
	self.ratio1Label.text = [NSString stringWithFormat:@"%d",(int)(perc1/100)];
	
	float ratio2PosX = (perc2/1000)*wrapperWidth;
	self.ratio2View.backgroundColor = [UIColor whiteColor];
	self.ratio2View.frame = CGRectMake((int)ratio2PosX, (int)ratio1PosY, 1, (int)(wrapperHeight-ratio1PosY) );

	self.ratio2Label.frame = CGRectMake(ratio2PosX-(tileSize/2), wrapperHeight, tileSize, tileSize);
	self.ratio2Label.text = [NSString stringWithFormat:@"%d",(int)(perc2/100)];
	
	float ratio3PosY = ((perc3/1000)*(wrapperHeight-ratio1PosY)) + ratio1PosY;
	self.ratio3View.backgroundColor = [UIColor whiteColor];
	self.ratio3View.frame = CGRectMake((int)ratio2PosX,(int)ratio3PosY , wrapperWidth-ratio2PosX, 1);
	
	self.ratio3Label.frame = CGRectMake(wrapperWidth+10, ratio3PosY-(tileSize/2), tileSize-10, tileSize);
	self.ratio3Label.text = [NSString stringWithFormat:@"%d",(int)(perc3/100)];
	
	float ratio4PosX = ((perc4/1000)*(wrapperWidth-ratio2PosX)) + ratio2PosX;
	self.ratio4View.backgroundColor = [UIColor whiteColor];
	self.ratio4View.frame = CGRectMake((int)ratio4PosX,(int)ratio3PosY, 1, wrapperHeight-ratio3PosY);
	
	self.ratio4Label.frame = CGRectMake(ratio4PosX-(tileSize/2), -1*tileSize, tileSize, tileSize);
	self.ratio4Label.text = [NSString stringWithFormat:@"%d",(int)(perc4/100)];
	
	self.ratio4NegView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile.png"]];
	self.ratio4NegView.frame = CGRectMake((int)ratio4PosX, 0, 1, (int)ratio1PosY);
	
	float ratio5PosY = ((perc5/1000)*(wrapperHeight-ratio3PosY)) + ratio3PosY;
	self.ratio5View.backgroundColor = [UIColor whiteColor];
	self.ratio5View.frame = CGRectMake((int)ratio4PosX,(int)ratio5PosY , wrapperWidth-ratio4PosX, 1);
	
	float ratio6PosX = ((perc6/1000)*(wrapperWidth-ratio4PosX)) + ratio4PosX;
	self.ratio6View.backgroundColor = [UIColor whiteColor];
	self.ratio6View.frame = CGRectMake((int)ratio6PosX,(int)ratio5PosY, 1, wrapperHeight-ratio5PosY);
	
	float ratio7PosY = ((perc7/1000)*(wrapperHeight-ratio5PosY)) + ratio5PosY;
	self.ratio7View.backgroundColor = [UIColor whiteColor];
	self.ratio7View.frame = CGRectMake((int)ratio6PosX,(int)ratio7PosY , wrapperWidth-ratio6PosX, 1);
	
	float ratio8PosX = ((perc8/1000)*(wrapperWidth-ratio6PosX)) + ratio6PosX;
	self.ratio8View.backgroundColor = [UIColor whiteColor];
	self.ratio8View.frame = CGRectMake((int)ratio8PosX,(int)ratio7PosY, 1, wrapperHeight-ratio7PosY);
	
	float ratio9PosY = ((perc9/1000)*(wrapperHeight-ratio7PosY)) + ratio7PosY;
	self.ratio9View.backgroundColor = [UIColor whiteColor];
	self.ratio9View.frame = CGRectMake((int)ratio8PosX,(int)ratio9PosY , wrapperWidth-ratio8PosX, 1);
	
}

- (void)fadeIn:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration
{
	[UIView beginAnimations: @"Fade In" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 1;
	[UIView commitAnimations];
}

- (void)fadeOut:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration
{
	[UIView beginAnimations: @"Fade Out" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 0;
	[UIView commitAnimations];
}

-(void)audioPlayerSounds: (NSString *)filename;
{
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	resourcePath = [resourcePath stringByAppendingString: [NSString stringWithFormat:@"/%@", filename] ];
	NSError* err;
	audioPlayerSounds = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
	
	audioPlayerSounds.volume = 0.5;
	audioPlayerSounds.numberOfLoops = 0;
	audioPlayerSounds.currentTime = 0;
	
	if(err)	{ NSLog(@"%@",err); }
	else	{
		[audioPlayerSounds prepareToPlay];
		[audioPlayerSounds play];
	}
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
