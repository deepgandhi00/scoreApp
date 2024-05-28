import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'matchStatusEnum.g.dart';

class MatchStatusEnum extends EnumClass {
  static Serializer<MatchStatusEnum> get serializer => _$matchStatusEnumSerializer;

  static const MatchStatusEnum IN_PROGRESS = _$IN_PROGRESS;
  static const MatchStatusEnum NOT_STARTED = _$NOT_STARTED;
  static const MatchStatusEnum COMPLETED = _$COMPLETED;
  static const MatchStatusEnum PAUSED = _$PAUSED;
  static const MatchStatusEnum RESUME = _$RESUME;
  static const MatchStatusEnum STARTED = _$STARTED;

  const MatchStatusEnum._(String name) : super(name);

  static BuiltSet<MatchStatusEnum> get values => _$values;
  static MatchStatusEnum valueOf(String name) => _$valueOf(name);
}