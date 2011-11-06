//
//  ViewController.m
//  Loyal3CodeTestN
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CodeTestMapView.h"
#import "FetchStuff.h"

// Google API allows a maximum of 50,000 meters or 50 kilometers
#define kMaximumMeters  5000

@implementation ViewController

- (IBAction) goToMapView: (id) sender
{
    AppDelegate * appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(appDelegate)
    {
        FetchStuff * fetchStuffObject = [[FetchStuff alloc] init];
        if(fetchStuffObject)
        {
            UINavigationController * navigationController = appDelegate.navigationController;
            CodeTestMapView * ctMapView = [[CodeTestMapView alloc] initWithNibName: @"CodeTestMapView" bundle: NULL];
            
            fetchStuffObject.radiusOfInterestingThings = (radiusSliderControl.value * kMaximumMeters);
            if(ctMapView)
            {
            // first, let's go get some information from Google
                NSString * latLngString = [fetchStuffObject getLatitudeAndLongitudeForPlace: nearLocationTextField.text];
                if(latLngString && ([latLngString length] > 5))
                {
                    NSArray * interestingLocations = [fetchStuffObject requestInformationForTypeOfPlace: typeOfPlaceTextField.text nearLocation: latLngString];
                    if(interestingLocations)
                    {
                        ctMapView.arrayofInterestingPlaces = interestingLocations;
                    }
                    
                    [latLngString release];
                }
                [navigationController pushViewController: ctMapView animated: YES];
             
                if(fetchStuffObject.ourLocationCoordinate.latitude != kUninitialzedLocation)
                {
                    [ctMapView centerMapToThisLocation: fetchStuffObject.ourLocationCoordinate];
                }
                [ctMapView release];
            }
            [fetchStuffObject release];
        }
    }
}

-(void) updateMetersLabel
{
    NSInteger value = (radiusSliderControl.value * kMaximumMeters);
    
    [metersLabel setText: [NSString stringWithFormat: @"%d Meters", value]];
}

-(IBAction) sliderTouched: (id) sender
{
    [self updateMetersLabel];
}

#pragma mark - Delegate Methods

// these two delegate methods dismiss the keyboard when we're done adding data to the text fields
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateMetersLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
