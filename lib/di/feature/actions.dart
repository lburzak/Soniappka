import 'package:easy_beck/di/domain.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/feature/actions/service/tasks_list_controller.dart';
import 'package:easy_beck/feature/actions/widget/material_tasks_list_router.dart';
import 'package:easy_beck/feature/actions/widget/task_grid.dart';
import 'package:flutter/material.dart';

class InjectedTasksGrid extends StatefulWidget {
  final Day day;

  const InjectedTasksGrid({super.key, required this.day});

  @override
  State<InjectedTasksGrid> createState() => _InjectedTasksGridState();
}

class _InjectedTasksGridState extends State<InjectedTasksGrid> {
  late final router = MaterialTasksListRouter(context: context);

  late final controller = TasksListController(
      watchBeckTestTask: domainDependencyGraph.watchBeckTestTask,
      checkBeckTestStatusForDay:
          domainDependencyGraph.checkBeckTestStatusForDay,
      toggleTask: domainDependencyGraph.toggleTask,
      router: router,
      day: widget.day);

  @override
  Widget build(BuildContext context) {
    return TasksGrid(
        tasks: controller.tasks,
        onToggleTask: controller.toggleTask,
        onNewTask: () {},
        onBeckTestOpen: controller.openBeckTest);
  }
}
