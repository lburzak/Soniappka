import 'package:flutter/material.dart';

class TaskStatusIndicator extends StatelessWidget {
  final bool completed;

  const TaskStatusIndicator({super.key, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: completed ? Colors.green : Colors.transparent,
        border: completed ? null : Border.all(color: Colors.grey, width: 2),
      ),
      child: completed
          ? const Icon(
              Icons.done,
              color: Colors.white,
              size: 15,
            )
          : SizedBox.shrink(),
    );
  }
}
