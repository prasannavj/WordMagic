//
//  defrost_textAppDelegate.h
//  defrost text
//
//  Created by hcl on 02/09/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class defrost_textViewController;

@interface defrost_textAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    defrost_textViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet defrost_textViewController *viewController;

@end

