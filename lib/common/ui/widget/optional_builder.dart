import 'package:flutter/widgets.dart';

class OptionalBuilder<T> extends StatelessWidget {
  final T? value;
  final Widget Function(BuildContext context, T value) builder;

  const OptionalBuilder(
      {super.key, required this.value, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: value != null,
        child: Builder(builder: (context) => builder(context, value as T)));
  }
}
