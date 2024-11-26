import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/attendance/domain/entities/attendance_entity.dart';
import '../../features/attendance/presentation/pages/attendance_image_full_screen.dart';
import '../../features/attendance/presentation/pages/attendance_screen.dart';
import '../../features/home/presentation/pages/absent_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/late_screen.dart';
import '../../features/home/presentation/pages/present_screen.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/message/presentation/pages/message_screen.dart';
import '../../features/navigation_bar/presentation/pages/bottom_navigation_bar.dart';
import '../../features/news/presentation/pages/create_news_screen.dart';
import '../../features/news/presentation/pages/news_screen.dart';
import '../../features/profile/presentation/pages/add_user_screen.dart';
import '../../features/profile/presentation/pages/change_password_screen.dart';
import '../../features/profile/presentation/pages/change_profile_picture_screen.dart';
import '../../features/profile/presentation/pages/edit_profile_information_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../utils/utils.dart';

part 'route_name.dart';

final _navigatorHome = GlobalKey<NavigatorState>();
final _navigatorNews = GlobalKey<NavigatorState>();
final _navigatorAttendance = GlobalKey<NavigatorState>();
final _navigatorMessage = GlobalKey<NavigatorState>();
final _navigatorProfile = GlobalKey<NavigatorState>();

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

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
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const AddUserScreen(),
      ),
      onExit: (context, state) {
        BlocFunction().initialProfile(context);
        return true;
      },
    ),
    GoRoute(
      path: '/present',
      name: RouteName().present,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: PresentScreen(
          attendance: state.extra as List<AttendanceEntity>,
        ),
      ),
    ),
    GoRoute(
      path: '/absent',
      name: RouteName().absent,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: AbsentScreen(
          attendance: state.extra as List<DateTime>,
        ),
      ),
    ),
    GoRoute(
      path: '/late',
      name: RouteName().late,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: LateScreen(
          attendance: state.extra as List<AttendanceEntity>,
        ),
      ),
    ),
    GoRoute(
      path: '/editProfileInformation',
      name: RouteName().editProfileInformation,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const EditProfileInformationScreen(),
      ),
    ),
    GoRoute(
      path: '/changeProfilePictureScreen',
      name: RouteName().changeProfilePictureScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const ChangeProfilePictureScreen(),
      ),
    ),
    GoRoute(
      path: '/changePassword',
      name: RouteName().changePassword,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const ChangePasswordScreen(),
      ),
      onExit: (context, state) {
        BlocFunction().initialProfile(context);
        return true;
      },
    ),
    GoRoute(
      path: '/attendancePictureScreen',
      name: RouteName().attendancePictureScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: AttendanceImageFullScreen(photo: state.extra as File?),
      ),
      onExit: (context, state) {
        BlocFunction().initialProfile(context);
        return true;
      },
    ),
    GoRoute(
      path: '/createNews',
      name: RouteName().createNews,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const CreateNewsScreen(),
      ),
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
