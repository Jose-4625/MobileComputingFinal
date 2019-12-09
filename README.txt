README.txt

NOTE:
- Core Location is working on the app. On initial start-up through an actual device, app will ask user to use current location. If access is granted by user, list will populate with events in the city the user is currently in. 
HOWEVER, iOS simulator does not implement Core Location to its full extent, so app will show a screen with no events on initial start-up through the simulator. To prove that Core Location is working for actual devices, we downloaded the app to an iPhone 7. 

Here is the link to the video: https://www.youtube.com/watch?v=OWsy15zKHYw

In the video, the Festive app is opened. Unfortunately, iOS screen capture does not capture pop up notifications, so the video only shows the dimming of the screen when the pop up comes up. The pop up notification that shows is the app asking to use your current location. I selected “Allow” which then shows events based in my current location, which is Austin. You can also see the location icon pop up in the navigation bar in the top right.

EXTRA CREDIT:
- Utilized EventKit to add events to your iOS calendar automatically through the Festive app. If you click the "Add to Calendar" and allow access to calendars and click the "Add to Calendar" button once again after allowing access, events will be created in the iOS calendar. You can check by going to the Calendar app and you will see an event created on the day the event is happening. If user denies access, "Add to Calendar" button will be hidden for all subsequent events.