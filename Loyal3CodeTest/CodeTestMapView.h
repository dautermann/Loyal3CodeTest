//
//  CodeTestMapView.h
//  Loyal3CodeTest
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKMapView.h>

@interface CodeTestMapView : UIViewController
{
    IBOutlet MKMapView * mapView;
    NSArray * arrayOfInterestingPlaces;
}

@property (atomic, retain) NSArray * arrayofInterestingPlaces;

- (void)centerMapToThisLocation: (CLLocationCoordinate2D) coordinate;
- (void)convertDataToAnnotations;

@end
