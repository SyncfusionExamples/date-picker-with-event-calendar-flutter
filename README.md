# Update event calendar (SfCalendar) DisplayDate using DatePicker in flutter 

In flutter event calendar, you can dynamically update the initialDisplayDate using DatePicker. 

![Binding date from datepicker to calendar](https://github.com/SyncfusionExamples/date-picker-with-event-calendar-flutter/blob/master/screenshots/Datepicker%20and%20calendar.gif)

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
    setState(() { 
      _datePicked = viewChangedDetails 
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]; 
    }); 
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
