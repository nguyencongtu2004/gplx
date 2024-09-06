import 'package:flutter/material.dart';
import 'package:gplx/screen/profile_screen.dart';
import 'package:gplx/screen/review_screen.dart';
import 'home_screen.dart';

class RoutePage {
  const RoutePage(this.index, this.route, this.title, this.icon, this.selectedIcon, this.color);

  final int index;
  final String route;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Color color;
}

const List<RoutePage> allRoutePages = [
  RoutePage(0, '/home', 'Học', Icons.school_outlined, Icons.school, Colors.teal),
  RoutePage(1, '/review', 'Tra Cứu', Icons.search_outlined, Icons.search, Colors.cyan),
  RoutePage(2, '/profile', 'Thông Tin', Icons.person_outlined, Icons.person, Colors.orange),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Tạo PageStorageKey cho mỗi trang
  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> _screens = [
    const HomeScreen(key: PageStorageKey('home')),
    const ReviewScreen(key: PageStorageKey('review')),
    const ProfileScreen(key: PageStorageKey('profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 60,
        indicatorColor: allRoutePages[_selectedIndex].color.withOpacity(0.1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: allRoutePages.map<NavigationDestination>(
              (RoutePage routePage) {
            return NavigationDestination(
              icon: Icon(routePage.icon, color: routePage.color, size: 35),
              label: routePage.title,
              selectedIcon: Icon(routePage.selectedIcon, color: routePage.color, size: 35),
              tooltip: routePage.title,
            );
          },
        ).toList(),
      ),
    );
  }
}