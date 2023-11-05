import 'package:easy_beck/common/loader.dart';
import 'package:easy_beck/isar/actions/isar_action_repository.dart';
import 'package:easy_beck/domain/actions/repository/action_repository.dart';
import 'package:easy_beck/isar/isar_loader.dart';
import 'package:kiwi/kiwi.dart';

class IsarContainer extends KiwiContainer {
  IsarContainer() : super.scoped() {
    registerSingleton((container) => IsarLoader());
    registerSingleton((container) => container<IsarLoader>().actionsCollection);
    registerSingleton<Loader>((container) => container<IsarLoader>());
    registerSingleton<ActionRepository>(
        (container) => IsarActionRepository(container()));
  }
}
