//
//  highscore.m
//  defrost text
//
//  Created by hcl on 07/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "highscore.h"


@implementation highscore


-(IBAction)cancellButton
{
	
	[self dismissModalViewControllerAnimated:YES];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];


	
	//Open the DB get the  next record and populate for the next display:
	
	NSString *docPath=[self docPath];	
	sqlite3 *db;
	//step1  Open the database
	if (sqlite3_open([docPath UTF8String], &db)==SQLITE_OK) {
		
		
		//const char *stment="select * from QuizMaster where SNo = '%@'",Glo	;
		NSString *nsstatement=[NSString stringWithFormat:@"select * from Settings where sno = 1"];
		const char *stment=[nsstatement UTF8String];
		sqlite3_stmt *statementObj;
		if (sqlite3_prepare(db, stment, -1, &statementObj, NULL)==SQLITE_OK) {
			//step 3 read the output from sqlite3_stmt
			while (sqlite3_step(statementObj)==SQLITE_ROW) {
				
				//Get the Setting details.
				const char *ch1=(char *)sqlite3_column_text(statementObj, 1);
				Myhighscore.text=[[NSString stringWithUTF8String:ch1]retain];
				NSLog(@"DBQuestion %@", [[NSString stringWithUTF8String:ch1]retain]);
				
			}
			
		}
		sqlite3_finalize(statementObj);
		
	}
	sqlite3_close(db);
	
	
	
}


//PRASANNA START SQLITE

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
