import 'package:collection/collection.dart';
import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart'
    as beck_test;
import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/beck_test_result_repository.dart'
    as symptoms_chart;
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class NoId implements BeckTestId {
  @override
  String serialize() {
    return "0";
  }
}

class DateTimeBeckTestId implements BeckTestId {
  final int value;

  DateTimeBeckTestId(DateTime dateTime) : value = dateTime.dayHashCode;

  DateTimeBeckTestId.fromDayHashCode(int dayHashCode) : value = dayHashCode;

  @override
  String serialize() {
    return value.toString();
  }
}

class HiveBeckTestResultRepository
    implements
        beck_test.BeckTestResultRepository,
        symptoms_chart.BeckTestResultRepository {
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
        .firstOrNull;
  }

  @override
  Stream<DateTime?> watchSubmissionDateTimeOfLast() async* {
    yield await findSubmissionDateTimeOfLast();
    yield* _box
        .watch()
        .flatMap((event) => findSubmissionDateTimeOfLast().asStream());
  }
}
