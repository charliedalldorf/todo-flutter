import 'package:flutter/material.dart';
import 'package:todo/models/events.dart';
import 'package:todo/services/sqlite.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Map<String, dynamic> _event;

  void _getEvent(int id) async {
    final data = await SQLite.getItem(id);
    setState(() {
      _event = data.first;
    });
  }

  void _deleteEvent(int id) async {
    await SQLite.deleteEvent(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted an Event!')));
  }

  @override
  void initState() {
    super.initState();
    _getEvent(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Event Details"),
        ),
        body: Container(
            padding: const EdgeInsets.all(12),
            child: Text(_event['eventName'])));
  }
}
