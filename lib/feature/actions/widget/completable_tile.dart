import 'package:easy_beck/feature/actions/widget/task_status_indicator.dart';
import 'package:flutter/material.dart';

class CompletableTile extends StatelessWidget {
  final String title;
  final Widget? hint;
  final Widget? icon;
  final bool completed;
  final void Function() onTap;

  const CompletableTile(
      {super.key,
      required this.title,
      this.hint,
      required this.icon,
      required this.completed,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: icon ?? SizedBox.expand()),
                    Text(title),
                    hint ?? const SizedBox.shrink()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskStatusIndicator(
                completed: completed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
