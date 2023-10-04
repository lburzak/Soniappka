import 'package:easy_beck/common/one_time_loader.dart';
import 'package:easy_beck/feature/actions/data/local_action.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarLoader extends OneTimeLoader {
  late IsarCollection<LocalAction> actionsCollection;

  @override
  Future<void> doLoad() async {
    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [LocalActionSchema],
      directory: dir.path,
    );

    actionsCollection = isar.localActions;

    if (await shouldBePrepopulated) {
      await prepopulate();
    }
  }

  Future<bool> get shouldBePrepopulated async =>
      actionsCollection.count().then((value) => value <= 0);

  Future<void> prepopulate() async {
    final json = await rootBundle.load("assets/default_actions.json");
    await actionsCollection.isar.writeTxn(() {
      return actionsCollection.importJsonRaw(json.buffer.asUint8List());
    });
  }
}
