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

@interface xxiivvViewController ()
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
	[self tmplStart];
	[self timeStart];
	[self timeUpdate];
}


- (void) tmplStart
{
	screen = [[UIScreen mainScreen] bounds];
	int margin = screen.size.width/10;
	float screenMargin = screen.size.width/4;
	
	
	self.uiFrame.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiOneth.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiTenth.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiHundredth.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiThousandth.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiMilli1.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiMilli2.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiMilli3.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.uiMilli4.frame = CGRectMake(margin, margin, screen.size.width-(margin*2), screen.size.width-(margin*2));
	self.displayTime.frame = CGRectMake(margin, (screen.size.width-(margin*2)), screen.size.width-(margin*2), (margin*2));
	self.displayTimeCompressed.frame = CGRectMake(margin, (screen.size.width-(margin*2)), screen.size.width-(margin*2), (margin*2));
	self.displayTime.hidden = NO;
	self.displayTimeCompressed.hidden = YES;
	
	[self setImage:self.uiFrame :@"watch_frame.png"];
	[self setImage:self.uiOneth :@"watch_oneth.png"];
	[self setImage:self.uiTenth :@"watch_tenth.png"];
	[self setImage:self.uiHundredth :@"watch_hundredth.png"];
	[self setImage:self.uiThousandth :@"watch_thousandth.png"];
	[self setImage:self.uiMilli1 :@"watch_milli1.png"];
	[self setImage:self.uiMilli2 :@"watch_milli2.png"];
	[self setImage:self.uiMilli3 :@"watch_milli3.png"];
	[self setImage:self.uiMilli4 :@"watch_milli4.png"];
	
	self.uiFrame.alpha = 0;
	self.uiOneth.alpha = 0;
	self.uiTenth.alpha = 0;
	self.uiHundredth.alpha = 0;
	self.uiThousandth.alpha = 0;
	self.displayTime.alpha = 0;
	
	[self fadeIn:self.uiOneth d:0.2 t:0.2];
	[self fadeIn:self.uiTenth d:0.4 t:0.2];
	[self fadeIn:self.uiHundredth d:0.6 t:0.2];
	[self fadeIn:self.uiThousandth d:0.8 t:0.2];
	
	[self fadeIn:self.uiFrame d:1.0 t:2.0];
	
	[self fadeIn:self.displayTime d:0.6 t:1.0];
	
	// Interactions
	
	self.btnFill.frame = screen;
	self.bgFade.frame = screen;
	self.bgFade.backgroundColor = [UIColor whiteColor];
	self.bgFade.alpha = 0;
	
	[self setImage:self.uiSupport :@"splash.support.png"];
	self.uiSupport.frame = CGRectMake(screenMargin, screen.size.height-( screen.size.width-(2*screenMargin) ) , screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
	self.uiSupport.alpha = 0;
	
	self.btnSupport.alpha = 0;
	self.btnSupport.frame = CGRectMake(screenMargin, screen.size.height-( screen.size.width-(2*screenMargin) ) , screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
	
}


- (void) timeStart
{
	NSLog(@"Time: Start");
	[NSTimer scheduledTimerWithTimeInterval:3.375 target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES];
}

- (void) timeUpdate
{
	
	NSDate *currentTime = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH"]; // @"hh-mm"
	NSString *t_hour = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"mm"]; // @"hh-mm"
	NSString *t_minu = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"ss"]; // @"hh-mm"
	NSString *t_seco = [dateFormatter stringFromDate: currentTime];
	
	double t_mili = [currentTime timeIntervalSinceNow] * -1000.0;
	float t_time = ( [t_hour intValue] * 60 * 60 ) + ( [t_minu intValue] * 60 ) + [t_seco intValue] + t_mili;
	float timePercent = t_time / 86400; // percentage
	
	float uiOnethRotation = timePercent*360;
	float uiTenthRotation = timePercent*360*2;
	float uiHundredthRotation = timePercent*360*4;
	float uiThousandthRotation = timePercent*360*8;
	
	float uiMilli1Rotation = timePercent*360*16;
	float uiMilli2Rotation = timePercent*360*32;
	float uiMilli3Rotation = timePercent*360*64;
	float uiMilli4Rotation = timePercent*360*128;
	
	[self rotate:self.uiOneth t:0.2 d:uiOnethRotation];
	[self rotate:self.uiTenth t:0.2 d:uiTenthRotation];
	[self rotate:self.uiHundredth t:0.2 d:uiHundredthRotation];
	[self rotate:self.uiThousandth t:0.2 d:uiThousandthRotation];
	
	[self rotate:self.uiMilli1 t:0.2 d:uiMilli1Rotation];
	[self rotate:self.uiMilli2 t:0.2 d:uiMilli2Rotation];
	[self rotate:self.uiMilli3 t:0.2 d:uiMilli3Rotation];
	[self rotate:self.uiMilli4 t:0.2 d:uiMilli4Rotation];
	
	// Write time
	
	NSString *t_oneth = @"O";
	NSString *t_Tenth = @"O";
	NSString *t_Hundredth = @"O";
	NSString *t_Thousandth = @"O";
	NSString *t_Milli1 = @"O";
	NSString *t_Milli2 = @"O";
	NSString *t_Milli3 = @"O";
	NSString *t_Milli4 = @"O";
	
	while ( uiTenthRotation > 360) { uiTenthRotation = uiTenthRotation-360; }
	while ( uiHundredthRotation > 360) { uiHundredthRotation = uiHundredthRotation-360; }
	while ( uiThousandthRotation > 360) { uiThousandthRotation = uiThousandthRotation-360; }
	
	while ( uiMilli1Rotation > 360) { uiMilli1Rotation = uiMilli1Rotation-360; }
	while ( uiMilli2Rotation > 360) { uiMilli2Rotation = uiMilli2Rotation-360; }
	while ( uiMilli3Rotation > 360) { uiMilli3Rotation = uiMilli3Rotation-360; }
	while ( uiMilli4Rotation > 360) { uiMilli4Rotation = uiMilli4Rotation-360; }
	
	if( uiOnethRotation > 90 && uiOnethRotation < 270 ){ t_oneth = @"I"; }
	if( uiTenthRotation > 90 && uiTenthRotation < 270 ){ t_Tenth = @"I"; }
	if( uiHundredthRotation > 90 && uiHundredthRotation < 270 ){ t_Hundredth = @"I"; }
	if( uiThousandthRotation > 90 && uiThousandthRotation < 270 ){ t_Thousandth = @"I"; }
	
	if( uiMilli1Rotation > 90 && uiMilli1Rotation < 270 ){ t_Milli1 = @"I"; }
	if( uiMilli2Rotation > 90 && uiMilli2Rotation < 270 ){ t_Milli2 = @"I"; }
	if( uiMilli3Rotation > 90 && uiMilli3Rotation < 270 ){ t_Milli3 = @"I"; }
	if( uiMilli4Rotation > 90 && uiMilli4Rotation < 270 ){ t_Milli4 = @"I"; }
		
	self.displayTime.text = [NSString stringWithFormat:@"%@ %@ %@ %@ : %@ %@ %@ %@",t_oneth,t_Tenth,t_Hundredth,t_Thousandth, t_Milli1, t_Milli2, t_Milli3, t_Milli4];
	
	
	NSString *t1 = [self compress:[NSString stringWithFormat:@"%@%@%@%@",t_oneth,t_Tenth,t_Hundredth,t_Thousandth]];
	NSString *t2 = [self compress:[NSString stringWithFormat:@"%@%@%@%@",t_Milli1, t_Milli2, t_Milli3, t_Milli4]];
	
	self.displayTimeCompressed.text = [NSString stringWithFormat:@"%@%@",t1,[t2 uppercaseString]];

}

- (IBAction)btnFill:(id)sender {
	
	[self audioPlayerSounds:@"sounds.click.mp3"];
	
	self.bgFade.alpha = 0.2;
	
	[self fadeOut:self.bgFade d:0 t:0.5];
	
	if( self.btnSupport.alpha > 0 ){
		self.btnSupport.alpha = 0;
		[self fadeOut:self.uiSupport d:0 t:0.2];
		self.displayTimeCompressed.hidden = YES;
		self.displayTime.hidden = NO;
	}else{
		self.btnSupport.alpha = 1;
		[self fadeIn:self.uiSupport d:0 t:0.2];
		self.displayTimeCompressed.hidden = NO;
		self.displayTime.hidden = YES;
	}
	
}

- (IBAction)btnSupport:(id)sender {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wiki.xxiivv.com/Entaloneralie"]];	
	
}




- (NSString*) compress :(NSString*)uncompressed
{
	if( [uncompressed isEqual:@"OOOO"]){ return @"0"; }
	if( [uncompressed isEqual:@"OOOI"]){ return @"1"; }
	if( [uncompressed isEqual:@"OOIO"]){ return @"2"; }
	if( [uncompressed isEqual:@"OOII"]){ return @"3"; }
	
	if( [uncompressed isEqual:@"OIOO"]){ return @"4"; }
	if( [uncompressed isEqual:@"OIOI"]){ return @"5"; }
	if( [uncompressed isEqual:@"OIIO"]){ return @"6"; }
	if( [uncompressed isEqual:@"OIII"]){ return @"7"; }
	
	if( [uncompressed isEqual:@"IOOO"]){ return @"8"; }
	if( [uncompressed isEqual:@"IOOI"]){ return @"9"; }
	if( [uncompressed isEqual:@"IOIO"]){ return @"X"; }
	if( [uncompressed isEqual:@"IOII"]){ return @"E"; }
	
	if( [uncompressed isEqual:@"IIOO"]){ return @"D"; }
	if( [uncompressed isEqual:@"IIOI"]){ return @"T"; }
	if( [uncompressed isEqual:@"IIIO"]){ return @"A"; }
	if( [uncompressed isEqual:@"IIII"]){ return @"N"; }
	
	return @"error";
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

-(void)setImage :(UIImageView*)viewName :(NSString*)imageName
{
    NSString *imgFile = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    viewName.image = nil;
	viewName.image = [UIImage imageWithContentsOfFile:imgFile];
}

- (void)rotate:(UIView *)viewToRotate t:(NSTimeInterval)duration d:(CGFloat)degrees
{
	viewToRotate.transform = CGAffineTransformMakeRotation( ( 0 * M_PI ) / 180 );
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationBeginsFromCurrentState:YES];
	CGAffineTransform transform = CGAffineTransformMakeRotation( (( degrees * M_PI ) / 180) );
	viewToRotate.transform = transform;
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


@end
