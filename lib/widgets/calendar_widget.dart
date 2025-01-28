import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart'; // Import intl package

void main() {
  runApp(MaterialApp(
    home: CalendarScreen(),
  ));
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late EventDataSource _events;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _appointments = _getInitialDataSource();
    _events = EventDataSource(_appointments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Widget'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        dataSource: _events,
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            final date = details.date;
            if (date != null) {
              _showEventsDialog(context, date);
            }
          }
        },
      ),
    );
  }

  void _showEventsDialog(BuildContext context, DateTime date) {
    final eventsForDay = _appointments
        .where((event) =>
            event.startTime.year == date.year &&
            event.startTime.month == date.month &&
            event.startTime.day == date.day)
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Events for ${DateFormat('dd/MM/yyyy').format(date)}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eventsForDay.isNotEmpty)
                  ...eventsForDay.map(
                    (event) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(event.subject),
                        subtitle: Text(
                            'From: ${DateFormat('hh:mm a').format(event.startTime)}\n'
                            'To: ${DateFormat('hh:mm a').format(event.endTime)}'),
                      ),
                    ),
                  ),
                if (eventsForDay.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("No events for this day."),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showAddEventDialog(context, date);
                  },
                  child: Text('Add Event'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show Add Event Dialog
  void _showAddEventDialog(BuildContext context, DateTime date) {
    final titleController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
              ),
              TextField(
                controller: startTimeController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Start Time'),
                onTap: () async {
                  final time = await _pickTime(context, TimeOfDay.now());
                  if (time != null) {
                    startTimeController.text = _formatTime(date, time);
                  }
                },
              ),
              TextField(
                controller: endTimeController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'End Time'),
                onTap: () async {
                  final time = await _pickTime(context, TimeOfDay.now());
                  if (time != null) {
                    endTimeController.text = _formatTime(date, time);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    startTimeController.text.isNotEmpty &&
                    endTimeController.text.isNotEmpty) {
                  final startTime = _combineDateAndTime(
                      date, startTimeController.text, context);
                  final endTime = _combineDateAndTime(
                      date, endTimeController.text, context);

                  setState(() {
                    _appointments.add(
                      Appointment(
                        startTime: startTime,
                        endTime: endTime,
                        subject: titleController.text,
                        color: Colors.purple,
                        notes: 'Added manually',
                      ),
                    );
                    _events = EventDataSource(_appointments);
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context, TimeOfDay initialTime) {
    return showTimePicker(context: context, initialTime: initialTime);
  }

  String _formatTime(DateTime date, TimeOfDay time) {
    final DateTime combined = DateTime(
        date.year, date.month, date.day, time.hourOfPeriod, time.minute);
    return DateFormat('hh:mm a').format(combined);
  }

  DateTime _combineDateAndTime(
      DateTime date, String timeString, BuildContext context) {
    final timeParts = timeString.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1].split(' ')[0]);
    final isPM = timeString.toLowerCase().contains('pm');
    return DateTime(
      date.year,
      date.month,
      date.day,
      isPM && hours < 12 ? hours + 12 : hours,
      minutes,
    );
  }

  // Initial events data
  List<Appointment> _getInitialDataSource() {
    return <Appointment>[
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        subject: 'Crossfit',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime.now().add(Duration(days: 2)),
        endTime: DateTime.now().add(Duration(days: 2, hours: 1)),
        subject: 'Swimming',
        color: Colors.green,
      ),
    ];
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
