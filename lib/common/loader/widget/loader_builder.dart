import 'package:easy_beck/common/loader/loader.dart';
import 'package:flutter/widgets.dart';

class LoaderBuilder extends StatelessWidget {
  final Loader loader;
  final void Function()? onReady;

  const LoaderBuilder(
      {super.key,
      required this.builder,
      required this.loader,
      required this.onReady});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loader.load().then((_) => onReady?.call()),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? builder(context)
                : const SizedBox.shrink());
  }
}
