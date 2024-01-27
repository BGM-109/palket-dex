import 'package:go_router/go_router.dart';
import 'package:palketdex/app/core/responsive_center.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_detail_view.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_search_view.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      // shell route
      ShellRoute(
          builder: (context, state, child) => ResponsiveCenter(child: child),
          routes: [
            GoRoute(
                path: '/',
                name: PalketmonView.routeName,
                builder: (context, state) => const PalketmonView(),
                routes: [
                  GoRoute(
                      name: PalketmonDetailView.routeName,
                      path: 'palketmon/:pid',
                      builder: (context, state) {
                        final pid = state.pathParameters['pid']!;
                        final extra = state.extra as Palketmon;
                        return PalketmonDetailView(pid: pid, extra: extra);
                      }),
                  GoRoute(
                      name: PalketmonSearchView.routeName,
                      path: 'search',
                      builder: (context, state) => const PalketmonSearchView()),
                ]),
          ]),
    ],
  );
  return router;
}
