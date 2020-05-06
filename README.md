# How to update event calendar (SfCalendar) DisplayDate using showDatePicker in Flutter?

In flutter event calendar, you can dynamically update the initialDisplayDate using DatePicker. 

<img alt="Binding date from datepicker to calendar"  src="https://github.com/SyncfusionExamples/date-picker-with-event-calendar-flutter/blob/master/screenshots/Datepicker%20and%20calendar.gif" width="250" height="400" />|

## Step 1 

In initState(), set the default values such as view, initial  display date for SfCalendar, initial picked date for DatePicker. 

```xml
CalendarView _calendarView; 
DateTime _datePicked; 
DateTime _calendarDate; 

@override 
void initState() { 
  _calendarView = CalendarView.week; 
  _datePicked = DateTime.now(); 
  _calendarDate = DateTime.now(); 
  super.initState(); 
} 
```
  
# Step 2 
Trigger the `OnViewChanged` callback of the calendar and please find the following code for updating picked date of DatePicker from visible dates of the calendar and updating initialDisplayDate from picked date of the DatePicker widget. 

```xml
body: Column( 
  children: <Widget>[ 
    Expanded( 
      child: SfCalendar( 
        initialDisplayDate: _calendarDate, 
        view: _calendarView, 
        onViewChanged: _viewChanged, 
      ), 
    ), 
  ], 
), 

void _viewChanged(ViewChangedDetails viewChangedDetails) { 
  SchedulerBinding.instance.addPostFrameCallback((duration) {  
      _datePicked = viewChangedDetails 
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];  
  }); 
} 
```

## Step 3 
Using showDatePicker widget selecting a date and assign it to the calendar initialDisplayDate. 

```xml
actions: <Widget>[ 
  FlatButton( 
    onPressed: () { 
      showDatePicker( 
              context: context, 
              initialDate: _datePicked, 
              firstDate: DateTime(2000), 
              lastDate: DateTime(2100)) 
          .then((DateTime date) { 
        if (date != null && date != _calendarDate) 
          setState(() { 
            _calendarDate = date; 
          }); 
      }); 
    }, 
    child: Icon( 
      Icons.date_range, 
      color: Colors.white, 
    ), 
  ) 
], 
```
**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/11010/how-to-update-event-calendar-sfcalendar-displaydate-using-showdatepicker-in-flutter)**

**Screenshots**

<img alt="Display date"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-690/flut-690_img2.jpeg" width="250" height="500" />|
<img alt="Picker date"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-690/flut-690_img3.jpeg" width="250" height="500" />|
<img alt="picker display date"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-690/flut-690_img4.jpeg" width="250" height="500" />|
