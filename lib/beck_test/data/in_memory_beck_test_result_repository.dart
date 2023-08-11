import 'package:easy_beck/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/common/day.dart';

class InMemoryBeckTestId implements BeckTestId {
  final int key;

  InMemoryBeckTestId(this.key);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InMemoryBeckTestId &&
          runtimeType == other.runtimeType &&
          key == other.key;

  @override
  int get hashCode => key.hashCode;

  InMemoryBeckTestId.fresh() : key = -1;

  @override
  String serialize() {
    return key.toString();
  }

  factory InMemoryBeckTestId.deserialize(String data) {
    return InMemoryBeckTestId(int.parse(data));
  }
}

class InMemoryBeckTestResultRepository implements BeckTestResultRepository {
  final _results = <BeckTestResult>[];

  @override
  BeckTestId createId() {
    return InMemoryBeckTestId.fresh();
  }

  @override
  Future<BeckTestResult> insert(BeckTestResult beckTestResult) async {
    final id = InMemoryBeckTestId(_results.length);
    final result = beckTestResult.copyWith(id: id);
    _results.add(result);
    return result;
  }

  @override
  Future<BeckTestResult?> findById(BeckTestId id) async =>
      _results.where((element) => element.id == id).firstOrNull;

  @override
  Stream<BeckTestResult?> observeByDay(Day day) async* {
    yield _results
        .where((element) => element.submissionDateTime.toDay() == day)
        .firstOrNull;
  }

  @override
  Stream<List<BeckTestResult>> watchAll() {
    return Stream.value(_results);
  }
}
