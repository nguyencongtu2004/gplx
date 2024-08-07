import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/screen/chose_licence_class_screen.dart';
import 'package:gplx/screen/home_screen.dart';
import 'package:gplx/screen/learn_screen.dart';
import 'package:gplx/screen/profile_screen.dart';
import 'package:gplx/screen/review_screen.dart';

void main() {
  runApp(GPLXApp());
}

class RoutePage {
  const RoutePage(this.index, this.route, this.title, this.icon, this.selectedIcon, this.color);

  final int index;
  final String route;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Color color;
}

class GPLXApp extends StatefulWidget {
  GPLXApp({super.key});

  @override
  _GPLXAppState createState() => _GPLXAppState();
}

class _GPLXAppState extends State<GPLXApp> with TickerProviderStateMixin {
  static const List<RoutePage> allRoutePages = [
    RoutePage(0, '/home', 'Học', Icons.school_outlined, Icons.school, Colors.teal),
    RoutePage(1, '/review', 'Tra Cứu', Icons.search_outlined, Icons.search, Colors.cyan),
    RoutePage(2, '/profile', 'Thông Tin', Icons.person_outlined, Icons.person, Colors.orange),
  ];
  int selectedIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/home',
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        ShellRoute(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: HomeScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
            GoRoute(
              path: '/review',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: ReviewScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: ProfileScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
          ],
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
                  _animationController.forward(from: 0); // Restart the animation
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
        GoRoute(path: '/learn', builder: (context, state) {
          return LearnScreen();
        }),
      ],
    );

    _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/home',
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        StatefulShellRoute.indexedStack(
          branches: [
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: '/home',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: HomeScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
              ]
            ),
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: '/review',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ReviewScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
              ]
            ),
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: '/profile',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ProfileScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
                ],
            )
          ],

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
                  _animationController.forward(from: 0); // Restart the animation
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
        GoRoute(path: '/learn', builder: (context, state) {
          return LearnScreen();
        }),
        GoRoute(path: '/chose-licence-class', builder: (context, state) {
          return ChoseLicencesClassScreen();
        }),
      ],
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}