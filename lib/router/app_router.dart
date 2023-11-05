import 'package:easy_beck/common/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

typedef ScaffoldBuilder = Widget Function(BuildContext context, Widget child);
typedef BeckTestResultPageBuilder = Widget Function(
    BuildContext context, String idParameter);

class AppRouter extends GoRouter {
  final WidgetBuilder dashboardBuilder;
  final WidgetBuilder journalBuilder;
  final WidgetBuilder beckTestBuilder;
  final BeckTestResultPageBuilder beckTestResultBuilder;
  final ScaffoldBuilder scaffoldBuilder;
  final WidgetBuilder irritabilityPageBuilder;
  final WidgetBuilder sleepinessPageBuilder;
  final WidgetBuilder anxietyPageBuilder;

  AppRouter(
      {required GlobalKey<NavigatorState> rootNavigatorKey,
      required GlobalKey<NavigatorState> shellNavigatorKey,
      required this.dashboardBuilder,
      required this.journalBuilder,
      required this.scaffoldBuilder,
      required this.beckTestBuilder,
      required this.beckTestResultBuilder,
      required this.irritabilityPageBuilder,
      required this.sleepinessPageBuilder,
      required this.anxietyPageBuilder})
      : super(
            navigatorKey: rootNavigatorKey,
            initialLocation: RouteNames.dashboard,
            routes: [
              ShellRoute(
                  builder: (context, state, child) =>
                      scaffoldBuilder(context, child),
                  routes: [
                    GoRoute(
                        path: RouteNames.dashboard,
                        builder: (context, state) {
                          return dashboardBuilder(context);
                        }),
                    GoRoute(
                        path: RouteNames.journal,
                        pageBuilder: (context, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: journalBuilder(context),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: Curves.easeOut));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            }))
                  ]),
              GoRoute(
                  path: RouteNames.beckTest,
                  builder: (context, state) => beckTestBuilder(context)),
              GoRoute(
                  path:
                      "${RouteNames.beckTest}/:${_PathParams.beckTestId}/${RouteNames.beckTestResult}",
                  builder: (context, state) => beckTestResultBuilder(
                      context, state.pathParameters[_PathParams.beckTestId]!)),
              GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: RouteNames.irritabilityPage,
                  pageBuilder: (context, state) => CustomTransitionPage(
                      opaque: false,
                      barrierDismissible: true,
                      child: irritabilityPageBuilder(context),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      })),
              GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: RouteNames.sleepinessPage,
                  pageBuilder: (context, state) => CustomTransitionPage(
                      opaque: false,
                      barrierDismissible: true,
                      child: sleepinessPageBuilder(context),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      })),
              GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: RouteNames.anxietyPage,
                  pageBuilder: (context, state) => CustomTransitionPage(
                      opaque: false,
                      barrierDismissible: true,
                      child: anxietyPageBuilder(context),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      }))
            ]);
}

abstract class _PathParams {
  static const beckTestId = "beckTestId";
}
