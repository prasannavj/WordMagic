//
//  GamePage.m
//  defrost text
//
//  Created by hcl on 02/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePage.h"
#import "ImageMaskView.h"

#import <CoreGraphics/CoreGraphics.h>

@implementation GamePage
@synthesize Score,Result,ScoreLbl;
@synthesize Ans1,Ans2,Ans3,Ans4;
@synthesize CURRENTQUESTIONANSWERD;
@synthesize array;
@synthesize databasePath;
@synthesize  imgviewNormal;
@synthesize imageviewshaded;
@synthesize ImageArray1;
@synthesize Mylable;

@synthesize GlobalCount,GlobalLevel,GlobalSet,SettingDetails,highscorecomparison;

@synthesize GlobalImagePercentage;
@synthesize sharpImage;
@synthesize imageView;
@synthesize Answered;

@synthesize DBQuestion;
@synthesize DBAns1;
@synthesize DBAns2;	
@synthesize DBAns3;
@synthesize DBAns4;
@synthesize DBAnswer;
@synthesize DBAnsewrPosition;



@synthesize view1;


- (id)init
{
    self = [super init];
    if (self) {

			NSLog(@"I am inside Init");
	}
	
    return self;
}



-(void)getSettingDetails
{
	
	
	//Open the DB get the  next record and populate for the next display:
	
	NSString *docPath=[self docPath];	
	sqlite3 *db;
	//step1  Open the database
	if (sqlite3_open([docPath UTF8String], &db)==SQLITE_OK) {
		
		NSString *nsstatement=[NSString stringWithFormat:@"select * from Settings where sno = 1"];
		const char *stment=[nsstatement UTF8String];
		sqlite3_stmt *statementObj;
		if (sqlite3_prepare(db, stment, -1, &statementObj, NULL)==SQLITE_OK) {
			//step 3 read the output from sqlite3_stmt
			while (sqlite3_step(statementObj)==SQLITE_ROW) {
				
				//Get the Setting details.
				const char *ch1=(char *)sqlite3_column_text(statementObj, 2);
				SettingDetails=[[NSString stringWithUTF8String:ch1]retain];

				
				//Get the Setting details.
				const char *ch2=(char *)sqlite3_column_text(statementObj, 1);
				highscorecomparison=[[NSString stringWithUTF8String:ch2]retain];
				
				

				
				NSLog(@"DBQuestion %@", SettingDetails);
				
			}
			
		}
		sqlite3_finalize(statementObj);
		
	}
	sqlite3_close(db);
	
	
	
	
	
}


-(void) viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"I am inside Loadview");
	
	//Initialize to 1 whenever the page loads.
	GlobalCount =1;
	GlobalSet=1;
	GlobalLevel=1;
		
	
	//Get the settings details.
	
	SettingDetails = @"";
	[self getSettingDetails];
	//Based on the setting assign the actual global level, set and count.
	if([SettingDetails isEqualToString:@""])
	{	
		SettingDetails =@"0";
		
	}

	
	if([SettingDetails isEqualToString:@"0"])
	{
		GlobalLevel =1;
		GlobalSet=1;
		GlobalCount =1;
	}
	else if ([SettingDetails isEqualToString:@"1"]) {
		
		GlobalLevel =2;
		GlobalSet=1;
		GlobalCount=40;
	}else if ([SettingDetails isEqualToString:@"2"]) {
		GlobalLevel =3;
		GlobalSet=1;
		GlobalCount=70;
	}
	
	
	array = [[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three",nil];
	
	//Getting the SQLite db to the application:
	
	NSString *docsDir;
	NSArray *dirPaths;

	CURRENTQUESTIONANSWERD =FALSE;
	Answered = FALSE;
	 // Get the documents directory
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	docsDir = [dirPaths objectAtIndex:0];
	
	// Build the path to the database file
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"prasquiz.sqlite"]];
	

	[self copySQLiteFile];


	Score =  @"0";
	
 	ScoreLbl.text =Score;
	

	
	
	
	UIImage *sharpImage = [UIImage imageNamed:@"homepage.png"];	
	UIImageView *imgviewNormal = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,370)]autorelease];
	imgviewNormal.image = sharpImage;
	[self.view addSubview:imgviewNormal];
	
	
	NSLog(@"Imagearray 1 %@", [ImageArray1 count]);

	//Add the lable
UILabel	*Mylable = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 200)];

	//Add the Buttons

	UIButton *Ans1= [[UIButton alloc]init];
	UIButton *Ans2= [[UIButton alloc]init];
	UIButton *Ans3= [[UIButton alloc]init];
	UIButton *Ans4= [[UIButton alloc]init];
	

	
	//	self.view.backgroundColor = [UIColor blackColor];
//	[self Load:@"awordanimal.png" Nextimage:@"hideimage.png"


	
	DBQuestion  = [[ NSString alloc] initWithFormat:@"Welcme"];
	DBAns1  = [[ NSString alloc] initWithFormat:@"a"];
	DBAns2  = [[ NSString alloc] initWithFormat:@"e"];	
	DBAns3  = [[ NSString alloc] initWithFormat:@"i"];
	DBAns4  = [[ NSString alloc] initWithFormat:@"o"];
	DBAnswer  = [[ NSString alloc] initWithFormat:@"o"];
	DBAnsewrPosition  = [[ NSString alloc] initWithFormat:@"4"];
	
	[self Load:@"Welcme" Nextimage:@"finalimage2.png" Answer1:@"a" Answer2:@"e" Answer3:@"i" Answer4:@"o" Answer:@"o" AnsewerPos:@"4"];

}


//PRASANN START



-(NSString *) sqlitePath
{
	NSString *appPath=[[NSBundle mainBundle]bundlePath];
	appPath=[appPath stringByAppendingPathComponent:@"prasquiz.sqlite"];
	NSLog(@"Application Path %@",appPath);
	return appPath;
}


-(NSString *) docPath{
	NSArray *arry=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *docPath=[arry objectAtIndex:0];
	docPath=[docPath stringByAppendingPathComponent:@"prasquiz.sqlite"];
	NSLog(@" DocPath  %@",docPath);
	return docPath;
	
}

-(void) copySQLiteFile{
	NSFileManager *fl=[NSFileManager defaultManager];
	NSString *sqlPath=[self sqlitePath];
	NSString *docPath=[self docPath];
	
	if ([fl fileExistsAtPath:docPath]) {
		NSLog(@"File Exist");
	}else {
		NSLog(@"File DoesNot Exist");
		NSError *err;
		[fl copyItemAtPath:sqlPath toPath:docPath error:&err];
		NSLog(@"%@ ",err);
	}
	
	
}


//PRASANNA END SQLITE



-(void) Load:(NSString *)NextText Nextimage:(NSString *)blurredimage Answer1:(NSString *)ans1 Answer2:(NSString *)ans2 Answer3:(NSString *)ans3 Answer4:(NSString *)ans4 Answer:(NSString *)answer AnsewerPos:(NSString *)answerposition 
{
	
					NSLog(@"DBQuestion in load  before  %@", DBAnsewrPosition);
	// Add the Lable
//	UILabel *Mylable = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 200)];
	Mylable.textColor= [UIColor whiteColor];
	[Mylable setBackgroundColor:[UIColor clearColor]];
	[Mylable setText:NextText]; 
	[self.view addSubview:Mylable];

//	[Mylable release];
	//Add the Buttons:
	
	
	CGRect maskViewRect = CGRectMake(0,100,320,200);
	UIImage * blurImage = [UIImage imageNamed:blurredimage];
	ImageMaskView *view1 = [[[ImageMaskView alloc] initWithFrame:maskViewRect image:blurImage ] autorelease];
	view1.imageMaskFilledDelegate = self;
	[self.view addSubview:view1];
	
	[Ans1 setTitle:ans1 forState:UIControlStateNormal];
	[Ans1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[self.view addSubview:Ans1]; 

	[Ans2 setTitle:ans2 forState:UIControlStateNormal];
	[Ans2 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[self.view addSubview:Ans2]; 

	
	[Ans3 setTitle:ans3 forState:UIControlStateNormal];
	[Ans3 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[self.view addSubview:Ans3]; 

	[Ans4 setTitle:ans4 forState:UIControlStateNormal];
	[Ans4 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[self.view addSubview:Ans4]; 
	
						NSLog(@"DBQuestion in load after  %@", DBAnsewrPosition);
	
}


-(IBAction)NextPage
{	
	
	if (Answered == FALSE) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Word Magic"
															message:@"Please select one Answer" delegate:self 
												  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];	}else
	{
		
	
//	NSLog(@"Percentatge details %@", GlobalImagePercentage);
//	NSLog(@"Array coundt %i", [array count]);
	
//	[Mylable setText:@""];
//	[Mylable removeFromSuperview];

	CURRENTQUESTIONANSWERD =FALSE;
	[view1 release];
	[Mylable removeFromSuperview];
	//Open the DB get the  next record and populate for the next display:
	BOOL dataretrival;
	dataretrival =FALSE;
	NSString *docPath=[self docPath];	
	sqlite3 *db;
	//step1  Open the database
	if (sqlite3_open([docPath UTF8String], &db)==SQLITE_OK) {
		
		//step2 oreoare the statment
		
		
		//const char *stment="select * from QuizMaster where SNo = '%@'",Glo	;
		NSString *nsstatement=[NSString stringWithFormat:@"select * from QuizMaster where SNo = '%@' ",[NSNumber numberWithInteger:GlobalCount]];
		const char *stment=[nsstatement UTF8String];
		sqlite3_stmt *statementObj;
		if (sqlite3_prepare(db, stment, -1, &statementObj, NULL)==SQLITE_OK) {
			//step 3 read the output from sqlite3_stmt
			while (sqlite3_step(statementObj)==SQLITE_ROW) {
				
				//Question
				const char *ch1=(char *)sqlite3_column_text(statementObj, 1);
				DBQuestion=[[NSString stringWithUTF8String:ch1]retain];
				NSLog(@"DBQuestion %@", DBQuestion);
				
				const char *ch2=(char *)sqlite3_column_text(statementObj, 2);
				DBAns1=[[NSString stringWithUTF8String:ch2] retain];

				NSLog(@"DBQuestion %@", DBAns1);
				
				const char *ch3=(char *)sqlite3_column_text(statementObj, 3);
				DBAns2=[[NSString stringWithUTF8String:ch3]retain];
				DBAns2 = [DBAns2 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
				NSLog(@"DBQuestion %@", DBAns2);

				//Ans 3
				const char *ch4=(char *)sqlite3_column_text(statementObj, 4);
				DBAns3=[[NSString stringWithUTF8String:ch4]retain];
				DBAns3 = [DBAns3 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

				
				NSLog(@"DBQuestion %@", DBAns3);
				//Ans 4
				const char *ch5=(char *)sqlite3_column_text(statementObj, 5);
				DBAns4=[[NSString stringWithUTF8String:ch5]retain];
				NSLog(@"DBQuestion %@", DBAns4);
				//Answer
				const char *ch6=(char *)sqlite3_column_text(statementObj, 6);
				DBAnswer=[[NSString stringWithUTF8String:ch6]retain];
				DBAnswer = [DBAnswer stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
				NSLog(@"DBQuestion %@", DBAnswer);
				//Ansposition
				const char *ch7=(char *)sqlite3_column_text(statementObj, 7);
				DBAnsewrPosition=[[NSString stringWithUTF8String:ch7]retain];
				DBAnsewrPosition = [DBAnsewrPosition stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

				
				NSLog(@"DBQuestion in nextage  %@", DBAnsewrPosition);
				

				dataretrival = TRUE;
				
			}
			
		}
		sqlite3_finalize(statementObj);
		
	}
	sqlite3_close(db);
	
	if(GlobalCount <=100)
	{	
			GlobalCount = GlobalCount + 1;
		
	}else {
		GlobalCount =1;
	}

	Answered =FALSE;	
		
	if (dataretrival) {
		[self Load:DBQuestion Nextimage:@"finalimage2.png" Answer1:DBAns1 Answer2:DBAns2 Answer3:DBAns3 Answer4:DBAns4 Answer:DBAnswer AnsewerPos:DBAnsewrPosition];
	}
	else{
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Word Magic" message:@"Congrad you have come to the end of the Game... Go home and play again :)"	delegate:nil
							  cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
		[alert release];
	}

	
	
	}		
}


-(IBAction)Homepage
{
	
	
	//Get the current high score0.
	
	int currenthighscore = [highscorecomparison intValue]; 
	int actualscore = [Score intValue];
	if(currenthighscore < actualscore)
	{	
		//Update the latest High score details.
		
		
		NSString *docPath=[self docPath];	
		sqlite3 *db;
		//step1  Open the database
		if (sqlite3_open([docPath UTF8String], &db)==SQLITE_OK) {
			
			//		NSString *flatstring = MySlider.value ;
			//		int intvalue = [flatstring intValue];
			//		[NSString stringWithFormat:@"select * from QuizMaster where SNo == '%@' ",[NSNumber numberWithInteger:GlobalCount]];
			//const char *stment="select * from QuizMaster where SNo = '%@'",Glo	;
			NSString *nsstatement=[NSString stringWithFormat:@"Update Settings set highscore='%d' where sno=1",actualscore];
			const char *stment=[nsstatement UTF8String];
			sqlite3_stmt *statementObj;
			if (sqlite3_prepare(db, stment, -1, &statementObj, NULL)==SQLITE_OK) {
				//step 3 read the output from sqlite3_stmt
				while (sqlite3_step(statementObj)==SQLITE_ROW) {
				}
				
			}
			sqlite3_finalize(statementObj);
			
		}
		sqlite3_close(db);
		
		
		//Send a alert message to the user.
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Word Magic" message:@"Congrad Your score is the highest... Keepup."	delegate:nil
							  cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
		[alert release];
	}
	//Check for score difference.
	
	//Update the high score details.
	
	
	[self dismissModalViewControllerAnimated:YES];
}


-(IBAction)Answer1Selected
{
	Answered =TRUE;
	int AnsPos = [DBAnsewrPosition intValue];
	if (AnsPos == 1 && CURRENTQUESTIONANSWERD == FALSE) {
		
		int Myint = [Score intValue];
		Myint = Myint +10;
				NSLog(@"I am crashing 1%@", Score);
//		Score = [[NSString stringWithFormat:@"%d",Myint] stringValue];
//				[Score stringByAppendingFormat:@"%d":Myint];	
						Score = [[NSString stringWithFormat:@"%d",Myint] retain];
				NSLog(@"I am crashing 2%@", Score);
		ScoreLbl.text = Score;	
				NSLog(@"I am crashing 3%@", Score);
		[Ans1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
	}
	else {
		[Ans1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}

	CURRENTQUESTIONANSWERD =TRUE;
}
-(IBAction)Answer2Selected
{
			Answered =TRUE;
	int AnsPos = [DBAnsewrPosition intValue];
	if (AnsPos == 2 && CURRENTQUESTIONANSWERD == FALSE) {
		int Myint = [Score intValue];
				NSLog(@"I am crashing 1%@", Score);
		Myint = Myint +10;
//		Score = [[NSString stringWithFormat:@"%d",Myint] stringValue];
						Score = [[NSString stringWithFormat:@"%d",Myint] retain];
//				[Score stringByAppendingFormat:@"%d":Myint];	
				NSLog(@"I am crashing 2%@", Score);
		ScoreLbl.text = Score;
				NSLog(@"I am crashing 3%@", Score);
		[Ans2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
	}
	else
	{
		[Ans2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		
	}
	
	CURRENTQUESTIONANSWERD =TRUE;
}
-(IBAction)Answer3Selected
{
		Answered =TRUE;
	NSLog(@"DBQuestion in load after  %@", DBAnsewrPosition);
	int AnsPos = [DBAnsewrPosition intValue];
	if (AnsPos == 3 && CURRENTQUESTIONANSWERD == FALSE) {
		NSLog(@"I am crashing 1 %@", Score );
		int Myint = [Score intValue];
		Myint = Myint +10;
				NSLog(@"I am crashing 2%@", Score);
// Score = 		[String setStr:@"%d",Myint];
//		[Score stringByAppendingFormat:@"%d":Myint];	
				Score = [[NSString stringWithFormat:@"%d",Myint] retain];
		ScoreLbl.text = Score;
				NSLog(@"I am crashing 3%@", Score);
		[Ans3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
	
	}else {
				[Ans3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}

		CURRENTQUESTIONANSWERD =TRUE;
	
}
-(IBAction)Answer4Selected
{		Answered =TRUE;
	int AnsPos = [DBAnsewrPosition intValue];
	if (AnsPos == 4 && CURRENTQUESTIONANSWERD == FALSE) {
		int Myint = [Score intValue];
		Myint = Myint +10;
		NSLog(@"I am crashing 1%@", Score);
				Score = [[NSString stringWithFormat:@"%d",Myint] retain];
//				[Score stringByAppendingFormat:@"%d":Myint];	
		NSLog(@"I am crashing 2%@", Score);		
		ScoreLbl.text = Score;
				NSLog(@"I am crashing 3%@", Score);
		[Ans4 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];	
	}
	else {
				[Ans4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}

	CURRENTQUESTIONANSWERD =TRUE;
}



- (void)imageMaskView:(ImageMaskView *)maskView cleatPercentWasChanged:(float)clearPercent {

	NSLog(@"percent: %.2f", clearPercent);

	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[Ans1 release];
	[Ans2 release];
	[Ans3 release];
	[Ans4 release];
	[DBAnsewrPosition release];
	[DBQuestion release];
	[DBAns1 release];
	 [DBAns2 release];	
	 [DBAns3 release];
	 [DBAns4 release];
	

}


@end
