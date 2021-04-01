import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(InitialDisplayDate());

class InitialDisplayDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DisplayDate(),
    );
  }
}

class DisplayDate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarDisplayDate();
}

List<String> views = <String>[
  'Day',
  'Week',
  'WorkWeek',
  'Month',
  'Timeline Day',
  'Timeline Week',
  'Timeline WorkWeek'
];

class CalendarDisplayDate extends State<DisplayDate> {
  CalendarController _controller = CalendarController();
  DateTime? _datePicked = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
//    _datePicked = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: _datePicked!,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100))
                  .then((DateTime? date) {
                if (date != null) _controller.displayDate = date;
              });
            },
            child: Icon(
              Icons.date_range,
              color: Colors.white,
            ),
          )
        ],
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.calendar_today),
          itemBuilder: (BuildContext context) => views.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onSelected: (String value) {
            setState(() {
              if (value == 'Day') {
                _controller.view = CalendarView.day;
              } else if (value == 'Week') {
                _controller.view = CalendarView.week;
              } else if (value == 'WorkWeek') {
                _controller.view = CalendarView.workWeek;
              } else if (value == 'Month') {
                _controller.view = CalendarView.month;
              } else if (value == 'Timeline Day') {
                _controller.view = CalendarView.timelineDay;
              } else if (value == 'Timeline Week') {
                _controller.view = CalendarView.timelineWeek;
              } else if (value == 'Timeline WorkWeek') {
                _controller.view = CalendarView.timelineWorkWeek;
              }
            });
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfCalendar(
              view: CalendarView.week,
              controller: _controller,
              onViewChanged: _viewChanged,
            ),
          ),
        ],
      ),
    );
  }

  void _viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      _datePicked = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];
    });
  }
}
