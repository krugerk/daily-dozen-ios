# Testing: Date & Time

## Contents <a id="contents"></a>
[Date Transition Test](#date-transition-test-) •
[Date Transition Test](#date-transition-test-) •
[Resources](#resources-)

## Date Transition Test <a id="section-"></a><sup>[▴](#contents)</sup>

**Test Setup**

_iPhone, personal_

1. Open Daily Dozen checklist as the last activity of the phone for the day.
2. Touch "today" so that the date is showing. 
3. Set the phone aside until the next day.
4. On the next day, go directly back to the Daily Dozen checklist and run the tests listed below. 

_iPhone, test device_

> _Note: a **test phone** is preferred when changing the device date, since a device level date change must disable network time and can affect other file dates on the phone._

1. Open Daily Dozen checklist to today. 
2. Touch "today" so that the date is showing.
3. Go home. Then to go `Settings`.
4. In `Settings`, go to the General > Data & Time Screen
    * Disable "Set Automatically" to turn off network time
    * Change the current date
5. Return to the Daily Dozen app checklist. Try to navigate to the just set date.

_Simulator_

The iOS simulator does not have a mechanism to directly switch the simulator device date.

* Simulator `Setting` app does not include a `Date & Time` panel.
* Setting device Date & Time is a an Apple only protected API.
* Changing the simulator region (e.g. to a location across the dateline) only changes the text  formatting and does not change any date or time. _It's a format change, not a timezone change_. 

**Test Checklist**

`dateButton`, `dateButtonPressed`

* toggle back to display "Today" text if current display date equals actual today date 

`datePicker`

* needs to be able to reach current date after an overnight device date change

`backButton`, `backButtonPressed`

* "Back to today" needs to go to a new blank list after an overnight device date change
    * testing needs to verify that no current view data is lost

`viewSwiped`

* "Back to today" should go to a new blank "Today" screen after an overnight device date change 

_Item History_

* Calendar view should include current date as selectable after an overnight device date change

## History Calendar Date Selection <a id="history-calendar-date-selection-"></a><sup>[▴](#contents)</sup>


## Resources <a id="resources-"></a><sup>[▴](#contents)</sup>

* [Related: Common HTML Entities ⇗](https://github.com/nutritionfactsorg/daily-dozen-ios/issues/42)


