import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/feature/dashboard/ui/beck_test_already_solved_dialog.dart';
import 'package:easy_beck/feature/dashboard/service/dashboard_router.dart';
import 'package:easy_beck/router/day_parameter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiver/time.dart';

class MaterialDashboardRouter implements DashboardRouter {
  final BuildContext _context;
  final Clock _clock;

  @override
  void goToBeckTest() {
    _context.push("/beck-test");
  }

  @override
  void showBeckTestAlreadySolvedWarning({required void Function() onProceed}) {
    showDialog(
        context: _context,
        builder: (context) {
          return BeckTestAlreadySolvedDialog(onProceed: onProceed);
        });
  }

  @override
  void goToYesterdayDashboard() {
    final yesterday = _clock.daysAgo(1);
    final yesterdayParameter = DayParameter.fromDay(yesterday.toDay());
    _context.pushReplacement("/dashboard/${yesterdayParameter.serialize()}");
  }

  @override
  void goToTodayDashboard() {
    final today = _clock.now().toDay();
    final todayParameter = DayParameter.fromDay(today);
    _context.pushReplacement("/dashboard/${todayParameter.serialize()}");
  }

  const MaterialDashboardRouter({
    required BuildContext context,
    required Clock clock,
  })  : _context = context,
        _clock = clock;
}
