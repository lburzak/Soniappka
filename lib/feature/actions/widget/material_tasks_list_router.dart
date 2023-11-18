import 'package:easy_beck/feature/actions/service/tasks_list_router.dart';
import 'package:easy_beck/feature/actions/widget/beck_test_already_solved_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MaterialTasksListRouter implements TasksListRouter {
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

  const MaterialTasksListRouter({
    required BuildContext context,
  }) : _context = context;
}
