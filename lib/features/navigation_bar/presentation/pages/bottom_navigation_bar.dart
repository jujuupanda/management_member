import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';

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
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_filled,
          color: PaletteColor().lightGray,
        ),
        activeIcon: Icon(
          Icons.home_filled,
          color: PaletteColor().softBlack,
        ),
        label: "Beranda",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.newspaper,
          color: PaletteColor().lightGray,
        ),
        activeIcon: Icon(
          Icons.newspaper,
          color: PaletteColor().softBlack,
        ),
        label: "Berita",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_circle_outline,
          color: PaletteColor().lightGray,
        ),
        activeIcon: Icon(
          Icons.add_circle_outline,
          color: PaletteColor().softBlack,
        ),
        label: "Kehadiran",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
          color: PaletteColor().lightGray,
        ),
        activeIcon: Icon(
          Icons.message,
          color: PaletteColor().softBlack,
        ),
        label: "Pesan",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_rounded,
          color: PaletteColor().lightGray,
        ),
        activeIcon: Icon(
          Icons.person_rounded,
          color: PaletteColor().softBlack,
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
