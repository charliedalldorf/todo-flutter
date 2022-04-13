import 'package:flutter/material.dart';
import 'package:todo/services/sqlite.dart';
import 'package:todo/screens/eventPage.dart';

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

  void _goToDetails(context, id) {
    Navigator.of(context).pushNamed('event-details', arguments: id);
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
