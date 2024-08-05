import 'package:flutter/material.dart';
import 'package:gplx/screen/home-screen.dart';
import 'package:gplx/screen/profile-screen.dart';
import 'package:gplx/screen/review-screen.dart';

class Destination {
  const Destination(this.index, this.title, this.icon, this.selectedIcon, this.color);

  final int index;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Color color;
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with TickerProviderStateMixin<TabsScreen> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Học',Icons.school_outlined, Icons.school, Colors.teal), // Home screen
    Destination(1, 'Tra Cứu', Icons.search_outlined,Icons.search, Colors.cyan), // Review screen
    Destination(2, 'Thông Tin', Icons.person_outlined,Icons.person, Colors.orange), // Profile screen
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addStatusListener(
          (AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {}); // Rebuild unselected destinations offstage.
        }
      },
    );
    return controller;
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
          (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
          (int index) => buildFaderController(),
    ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews = allDestinations.map<Widget>(
          (Destination destination) {
        return FadeTransition(
          opacity: destinationFaders[destination.index].drive(tween),
          child: DestinationView(
            destination: destination,
            navigatorKey: navigatorKeys[destination.index],
          ),
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: allDestinations.map((Destination destination) {
          final int index = destination.index;
          final Widget view = destinationViews[index];
          if (index == selectedIndex) {
            destinationFaders[index].forward();
            return Offstage(offstage: false, child: view);
          } else {
            destinationFaders[index].reverse();
            if (destinationFaders[index].isAnimating) {
              return IgnorePointer(child: view);
            }
            return Offstage(offstage: true, child: view);
          }
        }).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: allDestinations[selectedIndex].color.withOpacity(0.1),
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: allDestinations.map<NavigationDestination>(
              (Destination destination) {
            return NavigationDestination(
              icon: Icon(destination.icon, color: destination.color, size: 35),
              label: destination.title,
              selectedIcon: Icon(destination.selectedIcon, color: destination.color, size: 35),
              tooltip: destination.title,
            );
          },
        ).toList(),
      ),
    );
  }
}

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (widget.destination.index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const ReviewScreen();
              case 2:
                return ProfileScreen();
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
