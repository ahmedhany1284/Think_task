
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:think_task/core/colors/app_colors.dart';
import 'package:think_task/features/admin/presentaion/view/admin-vew.dart';
import 'package:think_task/features/user/presentaion/view/user_view.dart';

Color navBackgroundColor = AppColors.secondary;
Color navActiveColor = AppColors.primary;
Color navInactiveColor = AppColors.label;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _buildNavItem(Icons.shield, "Admin"),
      _buildNavItem(Icons.person, "User"),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon, size: 25),
      title: (title),
      activeColorPrimary: navActiveColor,
      inactiveColorPrimary: navInactiveColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const AdminView(),
      const UserView(),
    ];
    return PersistentTabView(
      context,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: navBackgroundColor, // Default is Colors.white.
      resizeToAvoidBottomInset:
      true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
