import 'package:async/async.dart';
import 'package:easy_beck/common/loader/loader.dart';
import 'package:meta/meta.dart';

abstract class OneTimeLoader implements Loader {
  final _memoizer = AsyncMemoizer();

  @protected
  Future<void> doLoad();

  @override
  Future<void> load() => _memoizer.runOnce(doLoad);
}
