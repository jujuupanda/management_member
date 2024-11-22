import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/attendance/domain/entities/attendance_entity.dart';
import '../../features/attendance/presentation/pages/attendance_screen.dart';
import '../../features/home/presentation/pages/absent_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/late_screen.dart';
import '../../features/home/presentation/pages/present_screen.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/message/presentation/pages/message_screen.dart';
import '../../features/navigation_bar/presentation/pages/bottom_navigation_bar.dart';
import '../../features/news/presentation/pages/news_screen.dart';
import '../../features/profile/presentation/pages/add_user_screen.dart';
import '../../features/profile/presentation/pages/change_profile_picture_screen.dart';
import '../../features/profile/presentation/pages/edit_profile_information_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';

part 'route_name.dart';

final _navigatorHome = GlobalKey<NavigatorState>();
final _navigatorNews = GlobalKey<NavigatorState>();
final _navigatorAttendance = GlobalKey<NavigatorState>();
final _navigatorMessage = GlobalKey<NavigatorState>();
final _navigatorProfile = GlobalKey<NavigatorState>();

final GoRouter routerApp = GoRouter(
  routes: <RouteBase>[
    /// Route without parent
    GoRoute(
      path: '/',
      name: RouteName().splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    GoRoute(
      path: '/login',
      name: RouteName().login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/addUser',
      name: RouteName().addUser,
      builder: (context, state) {
        return const AddUserScreen();
      },
    ),
    GoRoute(
      path: '/present',
      name: RouteName().present,
      builder: (context, state) {
        return PresentScreen(
          attendance: state.extra as List<AttendanceEntity>,
        );
      },
    ),
    GoRoute(
      path: '/absent',
      name: RouteName().absent,
      builder: (context, state) {
        return AbsentScreen(
          attendance: state.extra as List<DateTime>,
        );
      },
    ),
    GoRoute(
      path: '/late',
      name: RouteName().late,
      builder: (context, state) {
        return LateScreen(
          attendance: state.extra as List<AttendanceEntity>,
        );
      },
    ),
    GoRoute(
      path: '/editProfileInformation',
      name: RouteName().editProfileInformation,
      builder: (context, state) {
        return const EditProfileInformationScreen();
      },
    ),
    GoRoute(
      path: '/changeProfilePictureScreen',
      name: RouteName().changeProfilePictureScreen,
      builder: (context, state) {
        return const ChangeProfilePictureScreen();
      },
    ),

    /// Route with parent
    /// if have many role in app, just add more StatefulShellRoute.indexedStack
    /// with different name and path name
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MyNavigationBar(
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _navigatorHome,
          routes: [
            GoRoute(
              path: "/home",
              name: RouteName().home,
              builder: (context, state) {
                return const HomeScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorNews,
          routes: [
            GoRoute(
              path: "/news",
              name: RouteName().news,
              builder: (context, state) {
                return const NewsScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorAttendance,
          routes: [
            GoRoute(
              path: "/attendance",
              name: RouteName().attendance,
              builder: (context, state) {
                return const AttendanceScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorMessage,
          routes: [
            GoRoute(
              path: "/message",
              name: RouteName().message,
              builder: (context, state) {
                return const MessageScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorProfile,
          routes: [
            GoRoute(
              path: "/profile",
              name: RouteName().profile,
              builder: (context, state) {
                return const ProfileScreen();
              },
            )
          ],
        ),
      ],
    ),
  ],
);
