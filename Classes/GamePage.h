//
//  GamePage.h
//  defrost text
//
//  Created by hcl on 02/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMaskView.h"
#import "/usr/include/sqlite3.h"

@interface GamePage : UIViewController <ImageMaskFilledDelegate>{

	
	
IBOutlet	UIImageView *imgviewNormal;
IBOutlet	UIImageView *imageviewshaded;
	NSMutableArray *ImageArray1;
	ImageMaskView *view1;
	UIImage *sharpImage;
	UIImageView *imageView;
IBOutlet	UILabel *Mylable;
	IBOutlet	UILabel *ScoreLbl;
	
	IBOutlet UIButton *Ans1;
	IBOutlet UIButton *Ans2;
	IBOutlet UIButton *Ans3;
	IBOutlet UIButton *Ans4;
	NSString *Result;
	NSString *Score;
	NSString *databasePath;
	NSInteger GlobalCount;
	NSInteger GlobalLevel;
	NSInteger GlobalSet;
	NSString *SettingDetails;
	NSString *highscorecomparison;
	
	float GlobalImagePercentage;
	NSMutableArray *array;
	
	
	NSString *DBQuestion;
	NSString *DBAns1;
	NSString *DBAns2;	
	NSString *DBAns3;
	NSString *DBAns4;
	NSString *DBAnswer;
	NSString *DBAnsewrPosition;
	BOOL Answered;
	BOOL CURRENTQUESTIONANSWERD;
	
	
}

//And property
@property(nonatomic) 	BOOL CURRENTQUESTIONANSWERD;
@property(nonatomic, retain)	IBOutlet	UILabel *ScoreLbl;
@property(retain)NSString *DBQuestion;
@property(retain)NSString *DBAns1;
@property(retain)NSString *DBAns2;	
@property(retain)NSString *DBAns3;
@property(retain)NSString *DBAns4;
@property(retain)NSString *DBAnswer;
@property(retain)NSString *DBAnsewrPosition;
@property(nonatomic)	BOOL Answered;


@property(nonatomic) 	float GlobalImagePercentage;
@property(nonatomic, retain)NSMutableArray *array;

@property(nonatomic) NSInteger GlobalCount;
@property(nonatomic) NSInteger GlobalLevel;
@property(nonatomic) NSInteger GlobalSet;
@property(nonatomic,retain) 	NSString *SettingDetails;
@property(nonatomic,retain) 	NSString *highscorecomparison;


@property(nonatomic, retain)	NSString *databasePath;
@property(nonatomic,retain) 	NSString *Result;
@property(nonatomic, retain) 	NSString *Score;
@property(nonatomic,retain) ImageMaskView *view1;
@property(nonatomic,retain) UIImageView *imgviewNormal;
@property(nonatomic,retain) UIImageView *imageviewshaded;
@property(nonatomic,retain) NSMutableArray *ImageArray1;
@property(nonatomic,retain) UIImage *sharpImage;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) 	UILabel *Mylable;

@property(nonatomic,retain) 	 UIButton *Ans1;
@property(nonatomic,retain) 	UIButton *Ans2;
@property(nonatomic,retain) 	 UIButton *Ans3;
@property(nonatomic,retain) 	UIButton *Ans4;


-(void) Load:(NSString *)NextText Nextimage:(NSString *)blurredimage Answer1:(NSString *)ans1 Answer2:(NSString *)ans2 Answer3:(NSString *)ans3 Answer4:(NSString *)ans4 Answer:(NSString *)answer AnsewerPos:(NSString *)answerposition;
-(IBAction)NextPage;
//-(void)Loadarray;

-(IBAction)Homepage;

-(IBAction)Answer1Selected;
-(IBAction)Answer2Selected;
-(IBAction)Answer3Selected;
-(IBAction)Answer4Selected;


-(void)getSettingDetails;

@end
