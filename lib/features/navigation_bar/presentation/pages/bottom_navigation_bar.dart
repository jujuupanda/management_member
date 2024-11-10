import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentIndex = 0;

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.child.goBranch(index);
  }

  bottomNavigationBarItem() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        activeIcon: Icon(
          Icons.home_filled,
          color: Colors.blueAccent,
        ),
        label: "Beranda",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.newspaper),
        activeIcon: Icon(
          Icons.newspaper,
          color: Colors.blueAccent,
        ),
        label: "Berita",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.corporate_fare_rounded),
        activeIcon: Icon(
          Icons.corporate_fare_rounded,
          color: Colors.blueAccent,
        ),
        label: "Kehadiran",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message),
        activeIcon: Icon(
          Icons.message,
          color: Colors.blueAccent,
        ),
        label: "Pesan",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        activeIcon: Icon(
          Icons.person_rounded,
          color: Colors.blueAccent,
        ),
        label: "Saya",
      ),
    ];
  }

  bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) => onTap(value),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: bottomNavigationBarItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
