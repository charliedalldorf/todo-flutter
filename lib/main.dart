import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/events.dart';
import 'package:todo/screens/network.dart';
import 'package:todo/screens/eventPage.dart';
import 'package:todo/screens/eventCreate.dart';
import 'package:todo/screens/contactCreate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'event': (context) => const Event(),
        'event-details': (context) => const EventPage(),
        'event-create': (context) => const EventCreate(),
        'contact-create': (context) => const ContactCreate()
      },
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.event),
                  text: 'Events',
                ),
                Tab(
                  icon: Icon(Icons.people),
                  text: 'Network',
                ),
              ],
            ),
            title: const Text('Antelope Network'),
          ),
          body: const TabBarView(
            children: [Home(), Event(), Network()],
          ),
        ),
      ),
    );
  }
}
