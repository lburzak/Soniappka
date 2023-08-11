import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late final CircularBottomNavigationController _controller;

  @override
  void initState() {
    _controller = CircularBottomNavigationController(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      controller: _controller,
      [
        TabItem(Icons.sunny, "Dzisiaj", Colors.red),
        TabItem(Icons.calendar_month, "Dziennik", Colors.green),
        TabItem(Icons.area_chart, "Statystyki", Colors.blue),
      ],
      selectedCallback: (pos) {
        switch (pos) {
          case 0:
            _navigate("/dashboard", pos!);
          case 1:
            _navigate("/journal", pos!);
          case 2:
            _navigate("/statistics", pos!);
        }
      },
    );
  }

  void _navigate(String path, int pos) {
    context.go(path);
    _controller.value = pos;
  }
}
