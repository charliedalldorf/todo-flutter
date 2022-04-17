import 'package:flutter/material.dart';
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

  // void _deleteEvent(int id) async {
  //   await SQLite.deleteEvent(id);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Successfully deleted an Event!')));
  // }

  void _goToContactCreate(context, id) {
    Navigator.of(context).pushNamed('contact-create', arguments: id);
  }

  @override
  void initState() {
    super.initState();
    _getEvent(1);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;

    final data = SQLite.getItem(id);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Event Details"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _goToContactCreate(context, id),
            icon: const Icon(Icons.add),
            label: const Text('Add Contact')),
        body: Container(
            padding: const EdgeInsets.all(12),
            child: Text(_event['eventName'])));
  }
}
