import 'package:flutter/material.dart';
import 'package:todo/models/events.dart';
import 'package:todo/services/sqlite.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  final Events _event = Events(0, '', '', '', '', '', 0);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          ),
                          ElevatedButton(
                            onPressed: () => onSubmit(),
                            child: const Text('Submit'),
                          )
                        ]
                      ],
                    ))))));
  }

  onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      await SQLite.createEvent(_event.eventName, _event.venueName, _event.city,
          _event.state, _event.description, 1);
      form.reset();
    }
  }
}
