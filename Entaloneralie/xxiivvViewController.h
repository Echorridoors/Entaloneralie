//
//  xxiivvViewController.h
//  Entaloneralie
//
//  Created by Devine Lu Linvega on 2013-06-01.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xxiivvViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *ratio1View;
@property (strong, nonatomic) IBOutlet UIView *ratio2View;
@property (strong, nonatomic) IBOutlet UIView *ratio3View;
@property (strong, nonatomic) IBOutlet UIView *ratio4View;
@property (strong, nonatomic) IBOutlet UIView *wrapperView;
@property (strong, nonatomic) IBOutlet UIView *ratio5View;
@property (strong, nonatomic) IBOutlet UIView *ratio6View;
@property (strong, nonatomic) IBOutlet UIView *ratio7View;
@property (strong, nonatomic) IBOutlet UIView *ratio8View;
@property (strong, nonatomic) IBOutlet UIView *ratio9View;

@property (strong, nonatomic) IBOutlet UIView *borderTopView;
@property (strong, nonatomic) IBOutlet UIView *borderBottomView;
@property (strong, nonatomic) IBOutlet UIView *borderRightView;
@property (strong, nonatomic) IBOutlet UIView *borderLeftView;

@property (strong, nonatomic) IBOutlet UILabel *ratio1Label;
@property (strong, nonatomic) IBOutlet UILabel *ratio2Label;
@property (strong, nonatomic) IBOutlet UILabel *ratio3Label;
@property (strong, nonatomic) IBOutlet UILabel *ratio4Label;

@property (strong, nonatomic) IBOutlet UIView *ratio4NegView;

@end

CGRect screen;

NSString *previous;
NSString *updated;