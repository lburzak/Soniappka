import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleepiness_prompt.dart';
import 'package:flutter/material.dart';
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
typedef BeckTestResultPageBuilder = Widget Function(
    BuildContext context, String idParameter);

class AppRouter extends GoRouter {
  final WidgetBuilder dashboardBuilder;
  final WidgetBuilder journalBuilder;
  final WidgetBuilder beckTestBuilder;
  final BeckTestResultPageBuilder beckTestResultBuilder;
  final ScaffoldBuilder scaffoldBuilder;
  final WidgetBuilder irritabilityPageBuilder;

  AppRouter(
      {required GlobalKey<NavigatorState> rootNavigatorKey,
        required GlobalKey<NavigatorState> shellNavigatorKey,
      required this.dashboardBuilder,
      required this.journalBuilder,
      required this.scaffoldBuilder,
      required this.beckTestBuilder,
      required this.beckTestResultBuilder,
      required this.irritabilityPageBuilder})
      : super(
            navigatorKey: rootNavigatorKey,
            initialLocation: "/dashboard",
            routes: [
              ShellRoute(
                  builder: (context, state, child) =>
                      scaffoldBuilder(context, child),
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
                        pageBuilder: (context, state) => CustomSlideTransition(
                              key: state.pageKey,
                              child: journalBuilder(context),
                            )),
                    GoRoute(
                        path: "/statistics",
                        pageBuilder: (context, state) => CustomSlideTransition(
                            key: state.pageKey, child: const Text("data"))),
                  ]),
              GoRoute(
                  path: "/beck-test",
                  builder: (context, state) => beckTestBuilder(context)),
              GoRoute(
                  path: "/beck-test/:beckTestId/result",
                  builder: (context, state) => beckTestResultBuilder(
                      context, state.pathParameters["beckTestId"]!)),
              GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: "/symptom/irritability",
                  pageBuilder: (context, state) => CustomTransitionPage(
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
                  path: "/symptom/sleepiness",
                  pageBuilder: (context, state) => CustomTransitionPage(
                      child: SafeArea(child: SleepinessPrompt(onSubmitted: (a) {})),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      })),
              GoRoute(
                  path: "/symptom/anxiety",
                  pageBuilder: (context, state) => CustomTransitionPage(
                      child: AnxietyPrompt(onSubmitted: (a) {}),
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
