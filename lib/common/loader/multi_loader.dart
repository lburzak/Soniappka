import 'package:easy_beck/common/loader/loader.dart';

class MultiLoader implements Loader {
  final List<Loader> loaders;

  const MultiLoader({
    required this.loaders,
  });

  @override
  Future<void> load() => Future.wait(loaders.map((e) => e.load()));
}
