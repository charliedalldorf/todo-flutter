import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/about.dart';
import 'package:todo/screens/event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  icon: Icon(Icons.book),
                  text: 'About',
                ),
                Tab(
                  icon: Icon(Icons.event),
                  text: 'Event',
                ),
              ],
            ),
            title: const Text('Antelope Network'),
          ),
          body: const TabBarView(
            children: [Home(), About(), Event()],
          ),
        ),
      ),
    );
  }
}
