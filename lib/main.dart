import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/events.dart';
import 'package:todo/screens/network.dart';
import 'package:todo/screens/eventPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'event-details': (context) => const EventPage()},
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
