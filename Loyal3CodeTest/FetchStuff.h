//
//  FetchStuff.h
//  Loyal3CodeTestN
//
//  Created by Michael Dautermann on 11/2/11.
//  Copyright (c) 2011 Try To Guess My Company Name. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"
#import <CoreLocation/CoreLocation.h>

#define kUninitialzedLocation   -999.00

@interface FetchStuff : NSObject
{
    SBJSON * jsonObject;
    CLLocationCoordinate2D ourLocationCoordinate;
}

@property (readonly) CLLocationCoordinate2D ourLocationCoordinate;
@property (readwrite) NSInteger radiusOfInterestingThings;

- (NSString *) getLatitudeAndLongitudeForPlace: (NSString *) locationString;
- (NSArray *) requestInformationForTypeOfPlace: (NSString *)typeString nearLocation: (NSString *)latitudeLongitudeString;

@end
