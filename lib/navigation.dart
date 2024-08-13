import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/screen/chose_licence_class_screen.dart';
import 'package:gplx/screen/home_screen.dart';
import 'package:gplx/screen/learn_screen.dart';
import 'package:gplx/screen/profile_screen.dart';
import 'package:gplx/screen/review_screen.dart';
import 'package:gplx/screen/signs_screen.dart';
import 'package:gplx/screen/splash_screen.dart';

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

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    StatefulShellRoute.indexedStack(
      // Các màn hình chính
      branches: [
        StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => HomeScreen(),
              ),
            ]
        ),
        StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: '/review',
                builder: (context, state) => ReviewScreen(),
              ),
            ]
        ),
        StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfileScreen(),
              ),
            ]
        )
      ],
      // Thanh điều hướng dưới cùng
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: 60,
            indicatorColor: allRoutePages
                .firstWhere((element) => element.route == state.fullPath)
                .color
                .withOpacity(0.1),
            selectedIndex: allRoutePages.indexWhere((element) => element.route == state.fullPath),
            onDestinationSelected: (index) {
              context.go(allRoutePages[index].route);
            },
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
      },
    ),
    // Các màn hình khác
    GoRoute(path: '/splash', builder: (context, state) {
      return const SplashScreen();
    }),
    GoRoute(path: '/learn/:chapter', builder: (context, state) {
      final chapter = int.parse(state.pathParameters['chapter']!);
      return LearnScreen(chapter: chapter);
    }),
    GoRoute(path: '/chose-licence-class', builder: (context, state) {
      return ChoseLicencesClassScreen();
    }),
    GoRoute(path: '/signs', builder: (context, state) {
      return const SignsScreen();
    }),
  ],
);
