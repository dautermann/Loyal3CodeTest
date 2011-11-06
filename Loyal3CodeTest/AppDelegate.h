//
//  AppDelegate.h
//  Loyal3CodeTest
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// "strong" and "weak" are new property keywords introduced with iOS 5 & ARC
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
