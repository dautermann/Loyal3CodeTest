//
//  CodeTestMapView.m
//  Loyal3CodeTest
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import "CodeTestMapView.h"
#import <MapKit/MKPinAnnotationView.h>

@implementation CodeTestMapView

@synthesize arrayofInterestingPlaces;

#pragma mark - Map Display 
// This returns a rectangle bounding all of the pins within the supplied array.
// I found this bit of code and the basic idea over at
// http://stackoverflow.com/questions/1336370/positioning-mkmapview-to-show-multiple-annotations-at-once
- (MKMapRect) getMapRectUsingAnnotations {
    NSArray * theAnnotations = [mapView annotations];
    MKMapPoint points[[theAnnotations count]];
    
    for (int i = 0; i < [theAnnotations count]; i++) {
        MKPointAnnotation *annotation = [theAnnotations objectAtIndex:i];
        points[i] = MKMapPointForCoordinate(annotation.coordinate);
    }
    
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:[theAnnotations count]];
    
    return [poly boundingMapRect];
}

// I'd like to center the map to the address and location which the user entered in
// but I'd also like to zoom the map to encompass all the various interesting things
// (currently defaulting to "Cafes", although this is user-changeable)
- (void)centerMapToThisLocation: (CLLocationCoordinate2D) coordinate
{
    MKMapRect rectOfOurInterestingThings = [self getMapRectUsingAnnotations];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rectOfOurInterestingThings);

    // this little bit basically ensures we don't zoom in tooooo closely
    if (region.span.latitudeDelta < 0.027) {
        region.span.latitudeDelta = 0.027;
    }
    
    if (region.span.longitudeDelta < 0.027) {
        region.span.longitudeDelta = 0.027;
    }

    [mapView setRegion:region];

    [mapView setCenterCoordinate: coordinate animated:YES];
}

- (void)convertDataToAnnotations
{
    for(NSDictionary * entryDetailDictionary in arrayofInterestingPlaces)
    {
        // these objects conform to the MKAnnotation protocol, needed to properly annotate (i.e. drop pins) in the map
        MKPointAnnotation * newObject = [[MKPointAnnotation alloc] init];
        if(newObject)
        {
            NSDictionary * geometryDictionary = [entryDetailDictionary objectForKey: @"geometry"];
            if(geometryDictionary)
            {
                NSDictionary * locationDictionary = [geometryDictionary objectForKey: @"location"];
                if(locationDictionary)
                {
                    CLLocationCoordinate2D clcoord;
                    NSString * thingName = [entryDetailDictionary objectForKey: @"name"];
                    NSString * addressString = [entryDetailDictionary objectForKey: @"vicinity"];
                    NSNumber * degreeNumber = [locationDictionary objectForKey: @"lat"];
    
                    clcoord.latitude = [degreeNumber doubleValue];
                    
                    degreeNumber = [locationDictionary objectForKey: @"lng"];
                    clcoord.longitude = [degreeNumber doubleValue];
                    NSLog( @"setting location %@ to lat %4.2f & long %4.2f", thingName, clcoord.latitude, clcoord.longitude);
                    [newObject setCoordinate: clcoord];
                    
                    [newObject setTitle: thingName];
                    [newObject setSubtitle: addressString];

                    [mapView addAnnotation: newObject];
                    [newObject release];
                }
            }
        }
    }
}

// this delegate method creates the pin annotation views and sets them up to be reused
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    if (!pinView)
    {
        MKPinAnnotationView * newView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:SFAnnotationIdentifier] autorelease];
        newView.animatesDrop = YES;
        newView.pinColor = MKPinAnnotationColorPurple; // too bad they don't let us use [UIColor purpleColor] or similar
        [newView setCanShowCallout: YES]; // we'd like to show the relevant information with each pin
        return newView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}

#pragma mark - Basic View Setup & Teardown stuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [arrayOfInterestingPlaces release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self convertDataToAnnotations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
