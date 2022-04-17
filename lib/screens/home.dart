import 'package:flutter/material.dart';
import 'package:todo/services/sqlite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _events = [];
  List<Map<String, dynamic>> _contacts = [];
  String activeEvents = "0";

  void _getEvents() async {
    final eventsData = await SQLite.getItems();
    final contactsData = await SQLite.getContacts();
    setState(() {
      _events = eventsData;
      _contacts = contactsData;
      activeEvents = _events.where((e) => e["isActive"] == 1).length.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      Container(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.event, color: Colors.white)),
                title: const Text('Total Events',
                    style: TextStyle(color: Colors.blue)),
                trailing: Text(
                  _events.length.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.event, color: Colors.white)),
                title: const Text('Number of Contacts',
                    style: TextStyle(color: Colors.blue)),
                trailing: Text(
                  _contacts.length.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.event, color: Colors.white)),
                title: const Text('Active Events',
                    style: TextStyle(color: Colors.blue)),
                trailing: Text(
                  activeEvents,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(body: Column(children: cards));
  }
}
