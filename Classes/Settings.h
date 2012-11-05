//
//  Settings.h
//  defrost text
//
//  Created by hcl on 07/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@interface Settings : UIViewController {

IBOutlet	UISlider *MySlider;
	
	NSString *SettingDetails;
}

@property (nonatomic,retain)	NSString *SettingDetails;
-(IBAction)Cancletohome;
-(IBAction)Savethesetting;
@end
