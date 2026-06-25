
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/dashboard/dashboard_screen.dart';
import '../../features/program/program_screen.dart';
import '../../features/bookmarks/bookmarks_screen.dart';
import '../../features/basics_101/basics_101_screen.dart';
import '../../features/basics_102/basics_102_screen.dart';
import '../../features/chapter_1/chapter_1_screen.dart';
import '../../features/chapter_2/chapter_2_screen.dart';
import '../../features/chapter_3/chapter_3_screen.dart';
import '../../features/chapter_4/chapter_4_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/shell/main_shell.dart';
import '../widgets/update_listener_wrapper.dart';

class ActiveBranchIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void changeIndex(int newIndex) {
    state = newIndex;
  }
}

final activeBranchIndexProvider = NotifierProvider<ActiveBranchIndexNotifier, int>(() {
  return ActiveBranchIndexNotifier();
});

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return UpdateListenerWrapper(
            child: MainShell(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/program',
                builder: (context, state) => const ProgramScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookmarks',
                builder: (context, state) => const BookmarksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/basics-101',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Basics101Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/basics-102',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Basics102Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chapter-1',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Chapter1Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chapter-2',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Chapter2Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chapter-3',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Chapter3Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chapter-4',
                builder: (context, state) {
                  final target = state.uri.queryParameters['target'];
                  return Chapter4Screen(targetModuleId: target);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
