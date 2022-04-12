import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.home,
      size: 150,
    ),
    Icon(
      Icons.book,
      size: 150,
    ),
    Icon(
      Icons.person,
      size: 150,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Antelope Network"),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          iconSize: 30,
          mouseCursor: SystemMouseCursors.grab,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'About'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Contacts'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped),
    );
  }
}
