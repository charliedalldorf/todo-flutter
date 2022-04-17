import 'package:flutter/material.dart';
import 'package:todo/models/contacts.dart';
import 'package:todo/services/sqlite.dart';

class ContactCreate extends StatefulWidget {
  const ContactCreate({Key? key}) : super(key: key);

  @override
  _ContactCreateState createState() => _ContactCreateState();
}

class _ContactCreateState extends State<ContactCreate> {
  final Contacts _contract = Contacts(0, '', '', '', 0, '', '');
  final _formKey = GlobalKey<FormState>();

  onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      await SQLite.createContact(_contract.contactName, _contract.phoneNumber,
          _contract.companyName, _contract.followUpDate, _contract.notes, 1);
      form.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a Contact"),
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
                                const InputDecoration(labelText: 'Name'),
                            onSaved: (val) =>
                                setState(() => _contract.contactName = val!),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Phone Number'),
                            onSaved: (val) =>
                                setState(() => _contract.phoneNumber = val!),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Company Name'),
                            onSaved: (val) =>
                                setState(() => _contract.companyName = val!),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Follow Up Date'),
                            onSaved: (val) =>
                                setState(() => _contract.followUpDate = val!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Notes'),
                            onSaved: (val) =>
                                setState(() => _contract.notes = val!),
                          )
                        ]
                      ],
                    ))))));
  }
}
