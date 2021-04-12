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
class CalendarDisplayDate extends State<DisplayDate> {
  final CalendarController _controller = CalendarController();
  DateTime? _datePicked = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(
                view: CalendarView.week,
                controller: _controller,
                onViewChanged: _viewChanged,
                allowedViews: [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                ],
              ),
            ),
          ],
        ),
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
