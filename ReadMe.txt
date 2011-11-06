Hi Marcel (and anyone else reading this),

Here's a more proper implementation of the Loyal3 code test.  

When I looked at the original spec ("build runnable app that retrieves data via a public API and interpret & display data in an interactive UI") in the interview room, I really wanted to add in at least a couple features that would truly impress you guys (i.e. using a navigation controller to "push" between data entry and data display, a map view with dropping pins, a dynamically changing radius triggered by a slider, etc.).  Unfortunately, I also took some mis-steps in attempting to do it using iOS 5 (the latest version of Xcode removed the iOS 4-compatible "template" applications I was accustomed to and put in new iOS 5 apps with Storyboard functionality).  I wasn't familiar enough to use Storyboard (only introduced a couple months ago) so that ended up wasting 1/3rd of the allotted 90 minutes, I also wasn't familiar with MapKit (even though I've done a number of CoreLocation-based apps in my iPhone career) but I relished the opportunity to do some cool MapKit stuff for the first time. 

Here's the overall architecture of the app:

1) 

Present a view where the user types in a type of place and a location (I've pre-filled in the two fields to use the values "Cafe" and "150 California Street, San Francisco" from the spec).

2) 

When the user clicks the "Find It" button, we step into a "Fetch Stuff" object to query Google's API for a JSON response and then parse the response into Objective C objects.  

3)

Once I have that list of objects representing the "things" I want to display in a map, I assign that list into the CodeTestMapView object and then push the map view via a navigation controller (using a navigation controller means the user can click a "back" button to go back and do another query).

I can think of a collection of additional features I'd love to do (do more thorough error detection and handling; have a disclosure button with the name of the thing which points to the Google-suggested web page for that thing; have a separate view that shows a nicely formatted text list, etc), but most importantly I wanted to get this app over to you by the end of the weekend.  Hopefully this will demonstrate that I do know what I am doing, for the most part, and that I would be an excellent fit for the role you have in mind at Loyal3.

Could any other better-than-average iPhone guy successfully complete the requested code test within 90 - 120 minutes?  Only if they were familiar with the Google Map API's, one of the various JSON parsing third party libraries and a laser focus on a likely-to-be-underwhelming U.I.  This particular implementation took me about 4 hours to do.

I hope I pass the audition.

Michael Dautermann
6-November-2011
