// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'beck_schema.dart';

class BeckSchemaMapper extends ClassMapperBase<BeckSchema> {
  BeckSchemaMapper._();

  static BeckSchemaMapper? _instance;
  static BeckSchemaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BeckSchemaMapper._());
      ResultMapper.ensureInitialized();
      QuestionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'BeckSchema';

  static List<Result> _$results(BeckSchema v) => v.results;
  static const Field<BeckSchema, List<Result>> _f$results =
      Field('results', _$results);
  static List<Question> _$questions(BeckSchema v) => v.questions;
  static const Field<BeckSchema, List<Question>> _f$questions =
      Field('questions', _$questions);

  @override
  final Map<Symbol, Field<BeckSchema, dynamic>> fields = const {
    #results: _f$results,
    #questions: _f$questions,
  };

  static BeckSchema _instantiate(DecodingData data) {
    return BeckSchema(data.dec(_f$results), data.dec(_f$questions));
  }

  @override
  final Function instantiate = _instantiate;

  static BeckSchema fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<BeckSchema>(map));
  }

  static BeckSchema fromJson(String json) {
    return _guard((c) => c.fromJson<BeckSchema>(json));
  }
}

mixin BeckSchemaMappable {
  String toJson() {
    return BeckSchemaMapper._guard((c) => c.toJson(this as BeckSchema));
  }

  Map<String, dynamic> toMap() {
    return BeckSchemaMapper._guard((c) => c.toMap(this as BeckSchema));
  }

  BeckSchemaCopyWith<BeckSchema, BeckSchema, BeckSchema> get copyWith =>
      _BeckSchemaCopyWithImpl(this as BeckSchema, $identity, $identity);
  @override
  String toString() {
    return BeckSchemaMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BeckSchemaMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return BeckSchemaMapper._guard((c) => c.hash(this));
  }
}

extension BeckSchemaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BeckSchema, $Out> {
  BeckSchemaCopyWith<$R, BeckSchema, $Out> get $asBeckSchema =>
      $base.as((v, t, t2) => _BeckSchemaCopyWithImpl(v, t, t2));
}

abstract class BeckSchemaCopyWith<$R, $In extends BeckSchema, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Result, ResultCopyWith<$R, Result, Result>> get results;
  ListCopyWith<$R, Question, QuestionCopyWith<$R, Question, Question>>
      get questions;
  $R call({List<Result>? results, List<Question>? questions});
  BeckSchemaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BeckSchemaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BeckSchema, $Out>
    implements BeckSchemaCopyWith<$R, BeckSchema, $Out> {
  _BeckSchemaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BeckSchema> $mapper =
      BeckSchemaMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Result, ResultCopyWith<$R, Result, Result>> get results =>
      ListCopyWith($value.results, (v, t) => v.copyWith.$chain(t),
          (v) => call(results: v));
  @override
  ListCopyWith<$R, Question, QuestionCopyWith<$R, Question, Question>>
      get questions => ListCopyWith($value.questions,
          (v, t) => v.copyWith.$chain(t), (v) => call(questions: v));
  @override
  $R call({List<Result>? results, List<Question>? questions}) =>
      $apply(FieldCopyWithData({
        if (results != null) #results: results,
        if (questions != null) #questions: questions
      }));
  @override
  BeckSchema $make(CopyWithData data) => BeckSchema(
      data.get(#results, or: $value.results),
      data.get(#questions, or: $value.questions));

  @override
  BeckSchemaCopyWith<$R2, BeckSchema, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BeckSchemaCopyWithImpl($value, $cast, t);
}

class ResultMapper extends ClassMapperBase<Result> {
  ResultMapper._();

  static ResultMapper? _instance;
  static ResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResultMapper._());
      MapperContainer.globals.useAll([DepressionLevelMapper()]);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Result';

  static int _$threshold(Result v) => v.threshold;
  static const Field<Result, int> _f$threshold =
      Field('threshold', _$threshold);
  static DepressionLevel _$level(Result v) => v.level;
  static const Field<Result, DepressionLevel> _f$level =
      Field('level', _$level);

  @override
  final Map<Symbol, Field<Result, dynamic>> fields = const {
    #threshold: _f$threshold,
    #level: _f$level,
  };

  static Result _instantiate(DecodingData data) {
    return Result(data.dec(_f$threshold), data.dec(_f$level));
  }

  @override
  final Function instantiate = _instantiate;

  static Result fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Result>(map));
  }

  static Result fromJson(String json) {
    return _guard((c) => c.fromJson<Result>(json));
  }
}

mixin ResultMappable {
  String toJson() {
    return ResultMapper._guard((c) => c.toJson(this as Result));
  }

  Map<String, dynamic> toMap() {
    return ResultMapper._guard((c) => c.toMap(this as Result));
  }

  ResultCopyWith<Result, Result, Result> get copyWith =>
      _ResultCopyWithImpl(this as Result, $identity, $identity);
  @override
  String toString() {
    return ResultMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ResultMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return ResultMapper._guard((c) => c.hash(this));
  }
}

extension ResultValueCopy<$R, $Out> on ObjectCopyWith<$R, Result, $Out> {
  ResultCopyWith<$R, Result, $Out> get $asResult =>
      $base.as((v, t, t2) => _ResultCopyWithImpl(v, t, t2));
}

abstract class ResultCopyWith<$R, $In extends Result, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? threshold, DepressionLevel? level});
  ResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ResultCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Result, $Out>
    implements ResultCopyWith<$R, Result, $Out> {
  _ResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Result> $mapper = ResultMapper.ensureInitialized();
  @override
  $R call({int? threshold, DepressionLevel? level}) =>
      $apply(FieldCopyWithData({
        if (threshold != null) #threshold: threshold,
        if (level != null) #level: level
      }));
  @override
  Result $make(CopyWithData data) => Result(
      data.get(#threshold, or: $value.threshold),
      data.get(#level, or: $value.level));

  @override
  ResultCopyWith<$R2, Result, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ResultCopyWithImpl($value, $cast, t);
}

class QuestionMapper extends ClassMapperBase<Question> {
  QuestionMapper._();

  static QuestionMapper? _instance;
  static QuestionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuestionMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Question';

  static int _$id(Question v) => v.id;
  static const Field<Question, int> _f$id = Field('id', _$id);
  static Map<String, String> _$answers(Question v) => v.answers;
  static const Field<Question, Map<String, String>> _f$answers =
      Field('answers', _$answers);

  @override
  final Map<Symbol, Field<Question, dynamic>> fields = const {
    #id: _f$id,
    #answers: _f$answers,
  };

  static Question _instantiate(DecodingData data) {
    return Question(data.dec(_f$id), data.dec(_f$answers));
  }

  @override
  final Function instantiate = _instantiate;

  static Question fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Question>(map));
  }

  static Question fromJson(String json) {
    return _guard((c) => c.fromJson<Question>(json));
  }
}

mixin QuestionMappable {
  String toJson() {
    return QuestionMapper._guard((c) => c.toJson(this as Question));
  }

  Map<String, dynamic> toMap() {
    return QuestionMapper._guard((c) => c.toMap(this as Question));
  }

  QuestionCopyWith<Question, Question, Question> get copyWith =>
      _QuestionCopyWithImpl(this as Question, $identity, $identity);
  @override
  String toString() {
    return QuestionMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            QuestionMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return QuestionMapper._guard((c) => c.hash(this));
  }
}

extension QuestionValueCopy<$R, $Out> on ObjectCopyWith<$R, Question, $Out> {
  QuestionCopyWith<$R, Question, $Out> get $asQuestion =>
      $base.as((v, t, t2) => _QuestionCopyWithImpl(v, t, t2));
}

abstract class QuestionCopyWith<$R, $In extends Question, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get answers;
  $R call({int? id, Map<String, String>? answers});
  QuestionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuestionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Question, $Out>
    implements QuestionCopyWith<$R, Question, $Out> {
  _QuestionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Question> $mapper =
      QuestionMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get answers => MapCopyWith($value.answers,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(answers: v));
  @override
  $R call({int? id, Map<String, String>? answers}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (answers != null) #answers: answers}));
  @override
  Question $make(CopyWithData data) => Question(
      data.get(#id, or: $value.id), data.get(#answers, or: $value.answers));

  @override
  QuestionCopyWith<$R2, Question, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _QuestionCopyWithImpl($value, $cast, t);
}
