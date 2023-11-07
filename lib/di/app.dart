import 'package:easy_beck/app/app.dart';
import 'package:easy_beck/common/loader/multi_loader.dart';
import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/di/isar.dart';
import 'package:easy_beck/di/router.dart';
import 'package:flutter/material.dart';

class InjectedApp extends StatelessWidget {
  InjectedApp({super.key});

  late final loader = MultiLoader(loaders: [
    hiveDependencyGraph.hiveLoader,
    isarDependencyGraph.isarLoader
  ]);

  @override
  Widget build(BuildContext context) {
    return App(
        routerConfig: routerDependencyGraph.appRouter,
        loader: loader,
    );
  }
}
