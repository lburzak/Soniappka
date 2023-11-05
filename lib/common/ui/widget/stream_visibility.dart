import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StreamVisibility extends HookWidget {
  final Stream<bool> visibilityStream;
  final Widget child;

  const StreamVisibility(
      {super.key, required this.visibilityStream, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: visibilityStream,
        builder: (context, visible) =>
            Visibility(visible: visible.data ?? false, child: child));
  }
}
