import 'package:flutter/material.dart';
import 'package:todo/services/sqlite.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = true;

  void _getEvents() async {
    final data = await SQLite.getItems();
    setState(() {
      _events = data;
      _isLoading = false;
    });
  }

  void _goToDetails(context, id) {
    Navigator.of(context).pushNamed('event-details', arguments: id);
  }

  void _goToCreate(context) {
    Navigator.of(context).pushNamed('event-create');
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _goToCreate(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Event')),
        body: _events.isEmpty
            ? const Center(child: Text("No Events Listed"))
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: _events.length,
                itemBuilder: (context, index) => Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_events[index]['id'].toString() +
                          '. ' +
                          _events[index]['eventName']),
                      subtitle: Text('at ' + _events[index]['venueName']),
                      textColor: Colors.black54,
                      trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  child: const Text("Details"),
                                  onPressed: () => (_goToDetails(
                                      context, _events[index]['id'])))
                            ],
                          )),
                    ))));
  }
}
