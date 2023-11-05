import 'package:flutter/widgets.dart';

class SafeFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final SafeAsyncWidgetBuilder<T> builder;

  const SafeFutureBuilder(
      {super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return builder(context, LoadingAsyncSnapshot(snapshot));
          } else if (snapshot.hasData) {
            return builder(context, DataAsyncSnapshot(snapshot));
          } else {
            return builder(context, ErrorAsyncSnapshot(snapshot));
          }
        });
  }
}

typedef SafeAsyncWidgetBuilder<T> = Widget Function(
    BuildContext context, SafeAsyncSnapshot<T> snapshot);

sealed class SafeAsyncSnapshot<T> {
  final AsyncSnapshot<T> baseSnapshot;

  SafeAsyncSnapshot(this.baseSnapshot);
}

class DataAsyncSnapshot<T> extends SafeAsyncSnapshot<T> {
  DataAsyncSnapshot(super.baseSnapshot);

  T get data => baseSnapshot.data!;
}

class ErrorAsyncSnapshot<T> extends SafeAsyncSnapshot<T> {
  ErrorAsyncSnapshot(super.baseSnapshot);

  Object get error => baseSnapshot.error!;
}

class LoadingAsyncSnapshot<T> extends SafeAsyncSnapshot<T> {
  LoadingAsyncSnapshot(super.baseSnapshot);
}
