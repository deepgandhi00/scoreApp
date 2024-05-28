// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchStatusEnum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MatchStatusEnum _$IN_PROGRESS = const MatchStatusEnum._('IN_PROGRESS');
const MatchStatusEnum _$NOT_STARTED = const MatchStatusEnum._('NOT_STARTED');
const MatchStatusEnum _$COMPLETED = const MatchStatusEnum._('COMPLETED');
const MatchStatusEnum _$PAUSED = const MatchStatusEnum._('PAUSED');
const MatchStatusEnum _$RESUME = const MatchStatusEnum._('RESUME');
const MatchStatusEnum _$STARTED = const MatchStatusEnum._('STARTED');

MatchStatusEnum _$valueOf(String name) {
  switch (name) {
    case 'IN_PROGRESS':
      return _$IN_PROGRESS;
    case 'NOT_STARTED':
      return _$NOT_STARTED;
    case 'COMPLETED':
      return _$COMPLETED;
    case 'PAUSED':
      return _$PAUSED;
    case 'RESUME':
      return _$RESUME;
    case 'STARTED':
      return _$STARTED;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MatchStatusEnum> _$values =
    new BuiltSet<MatchStatusEnum>(const <MatchStatusEnum>[
  _$IN_PROGRESS,
  _$NOT_STARTED,
  _$COMPLETED,
  _$PAUSED,
  _$RESUME,
  _$STARTED,
]);

Serializer<MatchStatusEnum> _$matchStatusEnumSerializer =
    new _$MatchStatusEnumSerializer();

class _$MatchStatusEnumSerializer
    implements PrimitiveSerializer<MatchStatusEnum> {
  @override
  final Iterable<Type> types = const <Type>[MatchStatusEnum];
  @override
  final String wireName = 'MatchStatusEnum';

  @override
  Object serialize(Serializers serializers, MatchStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  MatchStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MatchStatusEnum.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
