import 'package:flutter/material.dart';
import 'navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme:
          ThemeData(primarySwatch: Colors.purple, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
    );
  }
}
