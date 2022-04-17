import 'package:flutter/material.dart';
import 'package:todo/services/sqlite.dart';

class Network extends StatefulWidget {
  const Network({Key? key}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;

  void _getEvents() async {
    final data = await SQLite.getContacts();
    setState(() {
      _contacts = data;
      _isLoading = false;
    });
  }

  void _goToContactCreate(context) {
    Navigator.of(context).pushNamed('contact-create');
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
            onPressed: () => _goToContactCreate(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Contact')),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: _contacts.length,
                itemBuilder: (context, index) => Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_contacts[index]['contactName']),
                      subtitle: Text('at ' + _contacts[index]['companyName']),
                      textColor: Colors.black54,
                    ))));
  }
}
