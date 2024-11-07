

import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/pages/splash_screen.dart';

part 'route_name.dart';


final GoRouter routerApp = GoRouter(
  routes: <RouteBase>[
    /// Route without parent
    GoRoute(
      path: '/',
      name: RouteName().splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    /// Route with parent
    /// if have many role in app, just add more StatefulShellRoute.indexedStack
    /// with different name and path name
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) {
    //     return MyNavigationBar(
    //       child: navigationShell,
    //     );
    //   },
    //   branches: [
    //     StatefulShellBranch(
    //       navigatorKey: _navigatorHome,
    //       routes: [
    //         GoRoute(
    //           path: "/home",
    //           name: RouteName().home,
    //           builder: (context, state) {
    //             return const HomeScreen();
    //           },
    //         )
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       navigatorKey: _navigatorSearch,
    //       routes: [
    //         GoRoute(
    //           path: "/search",
    //           name: RouteName().search,
    //           builder: (context, state) {
    //             return const SearchScreen();
    //           },
    //         )
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       navigatorKey: _navigatorMessage,
    //       routes: [
    //         GoRoute(
    //           path: "/message",
    //           name: RouteName().message,
    //           builder: (context, state) {
    //             return const MessageScreen();
    //           },
    //         )
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       navigatorKey: _navigatorProfile,
    //       routes: [
    //         GoRoute(
    //           path: "/profile",
    //           name: RouteName().profile,
    //           builder: (context, state) {
    //             return const ProfileScreen();
    //           },
    //         )
    //       ],
    //     ),
    //   ],
    // ),
  ],
);