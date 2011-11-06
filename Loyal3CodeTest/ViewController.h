//
//  ViewController.h
//  Loyal3CodeTestN
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField * typeOfPlaceTextField;
    IBOutlet UITextField * nearLocationTextField;
    IBOutlet UISlider * radiusSliderControl;
    IBOutlet UILabel * metersLabel;
}

-(IBAction) sliderTouched: (id) sender;

@end
