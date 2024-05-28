// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addGoalModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddGoalModel> _$addGoalModelSerializer =
    new _$AddGoalModelSerializer();

class _$AddGoalModelSerializer implements StructuredSerializer<AddGoalModel> {
  @override
  final Iterable<Type> types = const [AddGoalModel, _$AddGoalModel];
  @override
  final String wireName = 'AddGoalModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, AddGoalModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isSecondaryTeam',
      serializers.serialize(object.isSecondaryTeam,
          specifiedType: const FullType(bool)),
      'mins',
      serializers.serialize(object.mins, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.playerId;
    if (value != null) {
      result
        ..add('playerId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.assistPlayerId;
    if (value != null) {
      result
        ..add('assistPlayerId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.scoreTypeId;
    if (value != null) {
      result
        ..add('scoreTypeId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  AddGoalModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddGoalModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'playerId':
          result.playerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'assistPlayerId':
          result.assistPlayerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'scoreTypeId':
          result.scoreTypeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'isSecondaryTeam':
          result.isSecondaryTeam = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'mins':
          result.mins = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AddGoalModel extends AddGoalModel {
  @override
  final int? playerId;
  @override
  final int? assistPlayerId;
  @override
  final int? scoreTypeId;
  @override
  final bool isSecondaryTeam;
  @override
  final int mins;

  factory _$AddGoalModel([void Function(AddGoalModelBuilder)? updates]) =>
      (new AddGoalModelBuilder()..update(updates))._build();

  _$AddGoalModel._(
      {this.playerId,
      this.assistPlayerId,
      this.scoreTypeId,
      required this.isSecondaryTeam,
      required this.mins})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isSecondaryTeam, r'AddGoalModel', 'isSecondaryTeam');
    BuiltValueNullFieldError.checkNotNull(mins, r'AddGoalModel', 'mins');
  }

  @override
  AddGoalModel rebuild(void Function(AddGoalModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddGoalModelBuilder toBuilder() => new AddGoalModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddGoalModel &&
        playerId == other.playerId &&
        assistPlayerId == other.assistPlayerId &&
        scoreTypeId == other.scoreTypeId &&
        isSecondaryTeam == other.isSecondaryTeam &&
        mins == other.mins;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jc(_$hash, assistPlayerId.hashCode);
    _$hash = $jc(_$hash, scoreTypeId.hashCode);
    _$hash = $jc(_$hash, isSecondaryTeam.hashCode);
    _$hash = $jc(_$hash, mins.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddGoalModel')
          ..add('playerId', playerId)
          ..add('assistPlayerId', assistPlayerId)
          ..add('scoreTypeId', scoreTypeId)
          ..add('isSecondaryTeam', isSecondaryTeam)
          ..add('mins', mins))
        .toString();
  }
}

class AddGoalModelBuilder
    implements Builder<AddGoalModel, AddGoalModelBuilder> {
  _$AddGoalModel? _$v;

  int? _playerId;
  int? get playerId => _$this._playerId;
  set playerId(int? playerId) => _$this._playerId = playerId;

  int? _assistPlayerId;
  int? get assistPlayerId => _$this._assistPlayerId;
  set assistPlayerId(int? assistPlayerId) =>
      _$this._assistPlayerId = assistPlayerId;

  int? _scoreTypeId;
  int? get scoreTypeId => _$this._scoreTypeId;
  set scoreTypeId(int? scoreTypeId) => _$this._scoreTypeId = scoreTypeId;

  bool? _isSecondaryTeam;
  bool? get isSecondaryTeam => _$this._isSecondaryTeam;
  set isSecondaryTeam(bool? isSecondaryTeam) =>
      _$this._isSecondaryTeam = isSecondaryTeam;

  int? _mins;
  int? get mins => _$this._mins;
  set mins(int? mins) => _$this._mins = mins;

  AddGoalModelBuilder();

  AddGoalModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _playerId = $v.playerId;
      _assistPlayerId = $v.assistPlayerId;
      _scoreTypeId = $v.scoreTypeId;
      _isSecondaryTeam = $v.isSecondaryTeam;
      _mins = $v.mins;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddGoalModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddGoalModel;
  }

  @override
  void update(void Function(AddGoalModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddGoalModel build() => _build();

  _$AddGoalModel _build() {
    final _$result = _$v ??
        new _$AddGoalModel._(
            playerId: playerId,
            assistPlayerId: assistPlayerId,
            scoreTypeId: scoreTypeId,
            isSecondaryTeam: BuiltValueNullFieldError.checkNotNull(
                isSecondaryTeam, r'AddGoalModel', 'isSecondaryTeam'),
            mins: BuiltValueNullFieldError.checkNotNull(
                mins, r'AddGoalModel', 'mins'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
