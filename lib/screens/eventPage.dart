// ignore: file_names
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

  void _deleteEvent(int id) async {
    await SQLite.deleteEvent(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted an Event!')));
  }

  void _goToContactCreate(context, id) {
    Navigator.of(context).pushNamed('contact-create', arguments: id);
  }

  AlertDialog _viewContacts() {
    return const AlertDialog(
      title: Text("View Contacts"),
      content: Text("List of Contacts here"),
      scrollable: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _getEvent(2);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 55.0),
        Text(
          _event["eventName"],
          style: const TextStyle(color: Colors.white, fontSize: 36.0),
        ),
        const SizedBox(
          width: 270.0,
          child: Divider(
            color: Colors.blue,
            thickness: 2,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 30.0,
                ),
              )),
          Expanded(
              flex: 1,
              child: Text(
                "  04/18/22 - 04/22/22",
                style: TextStyle(color: Colors.white),
              ))
        ]),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 30.0,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      "  " + _event["venueName"],
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 30.0,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      "  " + _event["city"] + ", " + _event["state"],
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("details.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .88)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 12.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    Text bottomContentText = Text(
      _event["description"],
      style: const TextStyle(fontSize: 18.0),
    );

    final deleteEventButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton.icon(
          label:
              const Text("Delete Event", style: TextStyle(color: Colors.red)),
          onPressed: () => _deleteEvent(id),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );

    final viewContactsButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton.icon(
          label:
              const Text("View Contacts", style: TextStyle(color: Colors.blue)),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return _viewContacts();
              }),
          icon: const Icon(
            Icons.select_all,
            color: Colors.blue,
          )),
    );

    final addContactButton = Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
            label: const Text("Add Contact",
                style: TextStyle(color: Colors.white)),
            onPressed: () => _goToContactCreate(context, id),
            icon: const Icon(Icons.person_add)));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            viewContactsButton,
            addContactButton,
            deleteEventButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
