import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_link/UI/screens/home_screen/home_screen.dart';
import 'package:life_link/UI/screens/notification_screen/notification_screen.dart';
import 'package:life_link/UI/screens/profile_screen/profile_screen.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: _onNavBarButtonTap,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.homeEmptyIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
              ),
              activeIcon: SvgPicture.asset(
                Assets.homeFilledIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.notificationEmptyIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
              ),
              activeIcon: SvgPicture.asset(
                Assets.notificationFilledIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.profileEmptyIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
              ),
              activeIcon: SvgPicture.asset(
                Assets.profileFilledIcon,
                height: SizeConfig.height20(context),
                width: SizeConfig.width20(context),
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              label: "Profile",
            ),
          ],
        ),
        body: _btmItems[_selectedIndex],
      ),
    );
  }

  void _onNavBarButtonTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
