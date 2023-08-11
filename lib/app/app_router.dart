import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

typedef ScaffoldBuilder = Widget Function(BuildContext context, Widget child);
typedef BeckTestResultPageBuilder = Widget Function(BuildContext context, String idParameter);

class AppRouter extends GoRouter {
  final WidgetBuilder dashboardBuilder;
  final WidgetBuilder journalBuilder;
  final WidgetBuilder beckTestBuilder;
  final BeckTestResultPageBuilder beckTestResultBuilder;
  final ScaffoldBuilder scaffoldBuilder;

  AppRouter({required GlobalKey<
      NavigatorState> navigatorKey, required this.dashboardBuilder, required this.journalBuilder, required this.scaffoldBuilder, required this.beckTestBuilder, required this.beckTestResultBuilder})
      : super(
      navigatorKey: navigatorKey,
      initialLocation: "/dashboard",
      routes: [
        ShellRoute(
            builder: (context, state, child) => scaffoldBuilder(context, child),
            routes: [
              GoRoute(
                  path: "/dashboard",
                  pageBuilder: (context, state) {
                    return CustomSlideTransition(
                        key: state.pageKey,
                        child: dashboardBuilder(context));
                  }),
              GoRoute(
                  path: "/journal",
                  pageBuilder: (context, state) =>
                      CustomSlideTransition(
                        key: state.pageKey,
                        child: journalBuilder(context),
                      )),
              GoRoute(
                  path: "/statistics",
                  pageBuilder: (context, state) =>
                      CustomSlideTransition(
                          key: state.pageKey, child: const Text("data"))),
            ]),
        GoRoute(
            path: "/beck-test",
            builder: (context, state) => beckTestBuilder(context)),
        GoRoute(
            path: "/beck-test/:beckTestId/result",
            builder: (context, state) =>
                beckTestResultBuilder(
                    context, state.pathParameters["beckTestId"]!))
      ]
  );
}
