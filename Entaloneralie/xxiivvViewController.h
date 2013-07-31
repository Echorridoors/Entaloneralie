//
//  xxiivvViewController.h
//  Entaloneralie
//
//  Created by Devine Lu Linvega on 2013-06-01.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xxiivvViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *bgFade;

@property (strong, nonatomic) IBOutlet UIImageView *uiFrame;
@property (strong, nonatomic) IBOutlet UIImageView *uiOneth;
@property (strong, nonatomic) IBOutlet UIImageView *uiTenth;
@property (strong, nonatomic) IBOutlet UIImageView *uiHundredth;
@property (strong, nonatomic) IBOutlet UIImageView *uiThousandth;

@property (strong, nonatomic) IBOutlet UIImageView *uiMilli1;
@property (strong, nonatomic) IBOutlet UIImageView *uiMilli2;
@property (strong, nonatomic) IBOutlet UIImageView *uiMilli3;
@property (strong, nonatomic) IBOutlet UIImageView *uiMilli4;

@property (strong, nonatomic) IBOutlet UILabel *displayTime;
@property (strong, nonatomic) IBOutlet UILabel *displayTimeCompressed;

@property (strong, nonatomic) IBOutlet UIButton *btnFill;

@property (strong, nonatomic) IBOutlet UIImageView *uiSupport;
@property (strong, nonatomic) IBOutlet UIButton *btnSupport;



@end

CGRect screen;

NSString *previous;
NSString *updated;