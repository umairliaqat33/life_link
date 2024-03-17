import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/home_screen/home_screen.dart';
import 'package:life_link/UI/screens/notification_screen/notification_screen.dart';
import 'package:life_link/UI/screens/profile_screen/profile_screen.dart';
import 'package:life_link/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _btmItems = [
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        onTap: _onNavBarButtonTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_sharp,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: _btmItems[_selectedIndex],
    );
  }

  void _onNavBarButtonTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
