import 'package:flutter/material.dart';
import 'package:todo/models/events.dart';
import 'package:todo/services/sqlite.dart';

class EventCreate extends StatefulWidget {
  const EventCreate({Key? key}) : super(key: key);

  @override
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final Events _event = Events(0, '', '', '', '', '', 0);
  final _formKey = GlobalKey<FormState>();

  onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      await SQLite.createEvent(_event.eventName, _event.venueName, _event.city,
          _event.state, _event.description, 1);
      form.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add an Event"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => onSubmit(),
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            label: const Text('Submit')),
        body: Form(
            key: _formKey,
            child: Scrollbar(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: AutofillGroup(
                        child: Column(
                      children: [
                        ...[
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Event Name'),
                            onSaved: (val) =>
                                setState(() => _event.eventName = val!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Venue Name'),
                            onSaved: (val) =>
                                setState(() => _event.venueName = val!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'City'),
                            onSaved: (val) =>
                                setState(() => _event.city = val!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'State'),
                            onSaved: (val) =>
                                setState(() => _event.state = val!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            onSaved: (val) =>
                                setState(() => _event.description = val!),
                          )
                        ]
                      ],
                    ))))));
  }
}
