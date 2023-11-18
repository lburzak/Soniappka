import 'package:easy_beck/feature/actions/data/beck_test_action.dart';
import 'package:easy_beck/domain/actions/model/task.dart';
import 'package:easy_beck/feature/actions/widget/task_tile.dart';
import 'package:easy_beck/common/ui/theme/colors.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';

class TasksGrid extends StatelessWidget {
  final Stream<List<Task>> tasks;
  final void Function(Task task) onToggleTask;
  final void Function() onNewTask;
  final void Function() onBeckTestOpen;

  const TasksGrid(
      {super.key,
      required this.tasks,
      required this.onToggleTask,
      required this.onNewTask,
      required this.onBeckTestOpen});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tasks,
      builder: (context, snapshot) => SliverGrid.builder(
          itemCount: snapshot.data?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) => TaskTile(
              task: snapshot.requireData[index],
              onToggle: () =>
                  snapshot.requireData[index].action == beckTestAction
                      ? onBeckTestOpen()
                      : onToggleTask(snapshot.requireData[index]))),
    );
  }
}

class _AddActionTile extends StatelessWidget {
  final void Function() onTap;

  const _AddActionTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Icon(
            Icons.add,
            size: 60,
            color: context.theme.colors.inactive,
          ),
        ),
      ),
    );
  }
}
