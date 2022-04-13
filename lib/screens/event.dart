// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:todo/models/events.dart';
import 'package:todo/services/sqlite.dart';

// Demonstrates how to use autofill hints. The full list of hints is here:
// https://github.com/flutter/engine/blob/master/lib/web_ui/lib/src/engine/text_editing/autofill_hint.dart
class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  final Events _event = Events(0, '', '');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Event Name'),
              onSaved: (val) => setState(() => _event.eventName = val!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onSaved: (val) => setState(() => _event.description = val!),
            ),
            Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => onSubmit(),
                  child: const Text('Submit'),
                ))
          ])),
    );
  }

  onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      await SQLite.createEvent(_event.eventName, _event.description);
      form.reset();
    }
  }
}
