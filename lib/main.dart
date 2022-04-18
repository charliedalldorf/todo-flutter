import 'package:flutter/material.dart';
import 'package:todo/navbar.dart';
import 'package:todo/screens/contactCreate.dart';
import 'package:todo/screens/eventCreate.dart';
import 'package:todo/screens/eventPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const NavBar(),
      theme: ThemeData(
          primaryColor: Colors.blue,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          })),
      routes: {
        'event-details': (context) => const EventPage(),
        'event-create': (context) => const EventCreate(),
        'contact-create': (context) => const ContactCreate()
      },
    );
  }
}
