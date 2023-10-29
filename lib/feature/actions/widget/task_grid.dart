import 'package:easy_beck/feature/actions/data/beck_test_action.dart';
import 'package:easy_beck/feature/actions/model/task.dart';
import 'package:easy_beck/feature/actions/widget/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TasksGrid extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task task) onToggleTask;
  final void Function() onNewTask;

  const TasksGrid(
      {super.key,
      required this.tasks,
      required this.onToggleTask,
      required this.onNewTask});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: tasks.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => TaskTile(
            task: tasks[index],
            onToggle: () => tasks[index].action == beckTestAction
                ? context.push("/beck-test")
                : onToggleTask(tasks[index])));
  }
}

class _AddActionTile extends StatelessWidget {
  final void Function() onTap;

  const _AddActionTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Card(
        child: Center(
          child: Icon(
            Icons.add,
            size: 60,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
