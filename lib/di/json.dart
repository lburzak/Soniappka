import 'package:easy_beck/json/beck_test/json_file_beck_repository.dart';

late final JsonDependencyContext jsonDependencyContext =
    JsonDependencyContext._();

class JsonDependencyContext {
  late final jsonFileBeckRepository = JsonFileBeckRepository();

  JsonDependencyContext._();
}
