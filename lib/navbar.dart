import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/events.dart';
import 'package:todo/screens/network.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _tabs = [const Home(), const Event(), const Network()];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Antelope Network")),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        elevation: 0,
        selectedItemColor: Colors.blue,
        unselectedFontSize: 13,
        iconSize: 30,
        selectedFontSize: 13,
        selectedIconTheme: const IconThemeData(color: Colors.blue, size: 40),
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Events", icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              label: "Network", icon: Icon(Icons.grid_view)),
        ],
      ),
    );
  }
}
