import 'package:easy_beck/common/loader.dart';
import 'package:flutter/material.dart';

class LoaderBuilder extends StatelessWidget {
  final Loader loader;

  const LoaderBuilder({super.key, required this.builder, required this.loader});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loader.load(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? builder(context)
                : const CircularProgressIndicator());
  }
}
