// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int index) onPressed;
  const BottomNavigation({
    super.key,
    required this.onPressed,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.video,
          ),
          label: 'Shorts',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
              ),
            ),
          ),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidBell),
          label: 'Subscriptions',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.rightFromBracket),
          label: 'Logout',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        widget.onPressed(value);
      },
    );
  }
}
