import 'package:flutter/material.dart';
import '../../../../core/theme/theme_data.dart';
import '../activities/activities_view.dart';
import '../user_profile/user_profile_view.dart';
import 'home_dashboard.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool _exitRequestedOnce = false;
  final List<Widget> _screens = [
    HomeDashboard(),
    ActivitiesView(),
    UserProfileView(),
  ];
  final List<BottomNavigationBarItem> _screenIcons = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_exitRequestedOnce) {
      return true; // exit app
    } else {
      _exitRequestedOnce = true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Are you sure you want to exit? Press back again to confirm.'),
          duration: const Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        _exitRequestedOnce = false; // reset after 2 seconds
      });

      return false; // don't exit yet
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _exitRequestedOnce,
      onPopInvokedWithResult: (value, onEvent){
        _onWillPop();
        setState(() {

        });
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // Prevent swipe
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colors(context).primaryColor500,
          unselectedItemColor: Colors.grey,
          backgroundColor: colors(context).grayColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          items: _screenIcons,
        ),
      ),
    );
  }
}



