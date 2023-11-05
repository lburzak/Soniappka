import 'package:collection/collection.dart';
import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/domain/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/hive/beck_test_result/date_time_beck_test_id.dart';
import 'package:easy_beck/hive/beck_test_result/no_id.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class HiveBeckTestResultRepository implements BeckTestResultRepository {
  final Box<BeckTestResult> _box;

  HiveBeckTestResultRepository(this._box);

  @override
  BeckTestId createId() {
    return NoId();
  }

  @override
  Future<BeckTestResult?> findById(BeckTestId id) async {
    final dateTimeId = id as DateTimeBeckTestId;
    return _box.get(dateTimeId.value);
  }

  @override
  Future<BeckTestResult> insert(BeckTestResult beckTestResult) async {
    final id = DateTimeBeckTestId(beckTestResult.submissionDateTime);
    _box.put(id.value, beckTestResult);
    return beckTestResult.copyWith(id: id);
  }

  @override
  Stream<BeckTestResult?> observeByDay(Day day) async* {
    yield _box.get(day.hashCode);
    yield* _box.watch(key: day.hashCode).map((event) => event.value);
  }

  @override
  Stream<Iterable<BeckTestResult>> watchAll() async* {
    yield _box.values;
    yield* _box.watch().map((event) => _box.values);
  }

  Future<DateTime?> findSubmissionDateTimeOfLast() async {
    return _box.values
        .map((e) => e.submissionDateTime)
        .sorted((a, b) => a.compareTo(b))
        .lastOrNull;
  }

  @override
  Stream<DateTime?> watchSubmissionDateTimeOfLast() async* {
    yield await findSubmissionDateTimeOfLast();
    yield* _box
        .watch()
        .flatMap((event) => findSubmissionDateTimeOfLast().asStream());
  }
}
