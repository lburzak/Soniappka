import 'package:easy_beck/theme/borders.dart';
import 'package:easy_beck/theme/colors.dart';
import 'package:easy_beck/theme/theme_getter.dart';
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
        color: completed ? context.theme.colorScheme.primary : null,
        border: completed
            ? null
            : context.theme.borders.bold
                .copyWith(color: context.theme.colors.inactive),
      ),
      child: completed
          ? Icon(
              Icons.done,
              color: context.theme.colorScheme.onPrimary,
              size: 15,
            )
          : const SizedBox.shrink(),
    );
  }
}

extension CopyBorder on Border {
  Border copyWith({Color? color, double? width}) {
    return Border(
        top: top.copyWith(color: color, width: width),
        bottom: bottom.copyWith(color: color, width: width),
        left: left.copyWith(color: color, width: width),
        right: right.copyWith(color: color, width: width));
  }
}
