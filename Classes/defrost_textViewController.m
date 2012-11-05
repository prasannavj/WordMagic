//
//  defrost_textViewController.m
//  defrost text
//
//  Created by hcl on 02/09/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "defrost_textViewController.h"
#import "GamePage.h"
#import "Aboutus.h"
#import "Settings.h"
#import "highscore.h"

@implementation defrost_textViewController

-(IBAction)aboutus
{
	
	AboutUs *aboutuspage = [[AboutUs alloc]initWithNibName:@"AboutUs" bundle:nil];
	[self presentModalViewController:aboutuspage animated:YES];
	[aboutuspage release];
}



//PRASANNA START SQLITE

-(NSString *) sqlitePath
{
	
	//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//   NSString *documentsDirectory = [paths objectAtIndex:0];
	
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

//PRASANNA SQlite END

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(IBAction)HigScore
{
	
	highscore *Myhighscore = [[highscore alloc]initWithNibName:@"highscore" bundle:nil];
	[self presentModalViewController:Myhighscore animated:YES];
	[Myhighscore release];
	
}


-(IBAction)Setting1
{
	
	Settings *MySettings = [[Settings alloc]initWithNibName:@"Settings" bundle:nil];
	[self presentModalViewController:MySettings animated:YES];
	[MySettings release];
}

-(IBAction)LetusPlay
{

	NSLog(@"I am Calling the gamePage");
	
	GamePage *Mygame = [[GamePage alloc]initWithNibName:@"GamePage" bundle:nil];
	
	[self presentModalViewController:Mygame animated:YES];
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self copySQLiteFile];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
