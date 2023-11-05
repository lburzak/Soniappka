import 'package:easy_beck/feature/dashboard/ui/beck_test_already_solved_dialog.dart';
import 'package:easy_beck/feature/dashboard/service/dashboard_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MaterialDashboardRouter implements DashboardRouter {
  final BuildContext _context;

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

  const MaterialDashboardRouter({
    required BuildContext context,
  }) : _context = context;
}
