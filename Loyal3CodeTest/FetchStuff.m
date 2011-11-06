//
//  FetchStuff.m
//  Loyal3CodeTestN
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import "FetchStuff.h"

@implementation FetchStuff

@synthesize ourLocationCoordinate;
@synthesize radiusOfInterestingThings;

- (id) init
{
    self = [super init];
    if(self)
    {
        jsonObject = [[SBJSON alloc] init];
        ourLocationCoordinate.latitude = kUninitialzedLocation;
        ourLocationCoordinate.longitude = kUninitialzedLocation;
    }
    return(self);
}

- (void) dealloc
{
    [jsonObject release];
    [super dealloc];
}

// Step 1 in getting the nearest thing... find our latitude and longitude.  
// The Google Places API only uses latitude and longitude and not addresses
- (NSString *) getLatitudeAndLongitudeForPlace: (NSString *) locationString
{
    NSString * resultString = NULL;
    NSString * fullyFormedURLString = [[NSString alloc] initWithFormat: @"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", locationString];
    if(fullyFormedURLString)
    {
        NSURL * URLtoRequestWith = [[NSURL alloc] initWithString: [fullyFormedURLString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        if(URLtoRequestWith)
        {
            NSError * error = NULL;
            NSStringEncoding encoding;
            NSString * jsonResult = [[NSString alloc] initWithContentsOfURL: URLtoRequestWith usedEncoding: &encoding error: &error];
            if(jsonResult)
            {
                NSDictionary * jsonDictionary = [jsonObject objectWithString: jsonResult error: &error];
                if(jsonDictionary)
                {
                    NSArray * resultsArray = [jsonDictionary objectForKey: @"results"];
                    if(resultsArray)
                    {
                        NSDictionary * resultsDictionary = [resultsArray objectAtIndex: 0];
                        if(resultsDictionary)
                        {
                            NSDictionary * geometryDictionary = [resultsDictionary objectForKey: @"geometry"];
                            if(geometryDictionary)
                            {
                                NSDictionary *locationDictionary = [geometryDictionary objectForKey: @"location"];
                                if(locationDictionary)
                                {
                                    NSString * latitude = [locationDictionary objectForKey: @"lat"];
                                    NSString * longitude = [locationDictionary objectForKey: @"lng"];
                                    
                                    if(latitude && longitude)
                                    {
                                        resultString = [[NSString alloc] initWithFormat: @"%@,%@", latitude, longitude];
                                        
                                        ourLocationCoordinate.latitude = [latitude doubleValue];
                                        ourLocationCoordinate.longitude = [longitude doubleValue];
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if(error)
                {
                    NSLog( @"error from trying to fetch latitude & longitude - %@ %@", [error domain], [error localizedDescription] );
                } else {
                    NSLog( @"did not retrieve anything useful from our latiude & longitude request" );
                }
            }
            [URLtoRequestWith release];
        }
        [fullyFormedURLString release];
    }
    return resultString;
}

// Step 2 in getting the nearest things... with our newly found coordinates
// we can get the nearest interesting things
- (NSArray *) requestInformationForTypeOfPlace: (NSString *)typeString nearLocation: (NSString *)latitudeLongitudeString
{
    NSArray * resultArray = NULL;
    NSString * fullyFormedURLString = [[NSString alloc] initWithFormat: @"https://maps.googleapis.com/maps/api/place/search/json?location=%@&radius=%d&types=food&sensor=false&key=AIzaSyBp3gyrwxzf9bsilVmPljZ2KqNCY84YQR8", latitudeLongitudeString, radiusOfInterestingThings];
    if(fullyFormedURLString)
    {
        NSURL * URLtoRequestWith = [[NSURL alloc] initWithString: [fullyFormedURLString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSLog( @"requesting with URL %@", fullyFormedURLString );
        if(URLtoRequestWith)
        {
            NSError * error = NULL;
            NSStringEncoding encoding;
            NSString * jsonResult = [[NSString alloc] initWithContentsOfURL: URLtoRequestWith usedEncoding: &encoding error: &error];
            if(jsonResult)
            {
                NSDictionary * jsonDictionary = [jsonObject objectWithString: jsonResult];
                NSLog( @"interesting results are %@", jsonResult );
                if(jsonDictionary)
                {
                    resultArray = [jsonDictionary objectForKey: @"results"];
                    NSLog( @"result Array is %d", [resultArray count] );
                }
            }
            
            [URLtoRequestWith release];
        }
        [fullyFormedURLString release];
    }
    return(resultArray);
}

@end
