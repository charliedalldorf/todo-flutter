import 'package:flutter/material.dart';
import 'package:todo/services/sqlite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = true;

  void _getEvents() async {
    final data = await SQLite.getItems();
    setState(() {
      _events = data;
      _isLoading = false;
    });
  }

  void _deleteEvent(int id) async {
    await SQLite.deleteEvent(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted an Event!')));
    _getEvents();
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) => Card(
                    color: Colors.cyan[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(_events[index]['id'].toString() +
                          '. ' +
                          _events[index]['eventName']),
                      subtitle: Text('at ' + _events[index]['venueName']),
                      trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteEvent(_events[index]['id']),
                              )
                            ],
                          )),
                    ))));
  }
}
