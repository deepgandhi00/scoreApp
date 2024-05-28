// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goalModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GoalModel> _$goalModelSerializer = new _$GoalModelSerializer();

class _$GoalModelSerializer implements StructuredSerializer<GoalModel> {
  @override
  final Iterable<Type> types = const [GoalModel, _$GoalModel];
  @override
  final String wireName = 'GoalModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, GoalModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'goalId',
      serializers.serialize(object.goalId, specifiedType: const FullType(int)),
      'matchId',
      serializers.serialize(object.matchId, specifiedType: const FullType(int)),
      'isSecondaryTeam',
      serializers.serialize(object.isSecondaryTeam,
          specifiedType: const FullType(int)),
      'mins',
      serializers.serialize(object.mins, specifiedType: const FullType(int)),
      'secondaryTeamName',
      serializers.serialize(object.secondaryTeamName,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.playerId;
    if (value != null) {
      result
        ..add('playerId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.playerName;
    if (value != null) {
      result
        ..add('playerName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.position;
    if (value != null) {
      result
        ..add('position')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assistPlayerId;
    if (value != null) {
      result
        ..add('assistPlayerId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.assistPlayerName;
    if (value != null) {
      result
        ..add('assistPlayerName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.scoreTypeId;
    if (value != null) {
      result
        ..add('scoreTypeId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.scoreType;
    if (value != null) {
      result
        ..add('scoreType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.primaryGoalCount;
    if (value != null) {
      result
        ..add('primaryGoalCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.secondaryGoalCount;
    if (value != null) {
      result
        ..add('secondaryGoalCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GoalModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GoalModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'goalId':
          result.goalId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'matchId':
          result.matchId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'playerId':
          result.playerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'playerName':
          result.playerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assistPlayerId':
          result.assistPlayerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'assistPlayerName':
          result.assistPlayerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'scoreTypeId':
          result.scoreTypeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'isSecondaryTeam':
          result.isSecondaryTeam = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'mins':
          result.mins = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'secondaryTeamName':
          result.secondaryTeamName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'scoreType':
          result.scoreType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'primaryGoalCount':
          result.primaryGoalCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'secondaryGoalCount':
          result.secondaryGoalCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GoalModel extends GoalModel {
  @override
  final int goalId;
  @override
  final int matchId;
  @override
  final int? playerId;
  @override
  final String? playerName;
  @override
  final String? position;
  @override
  final int? assistPlayerId;
  @override
  final String? assistPlayerName;
  @override
  final int? scoreTypeId;
  @override
  final int isSecondaryTeam;
  @override
  final int mins;
  @override
  final String secondaryTeamName;
  @override
  final String? scoreType;
  @override
  final int? primaryGoalCount;
  @override
  final int? secondaryGoalCount;

  factory _$GoalModel([void Function(GoalModelBuilder)? updates]) =>
      (new GoalModelBuilder()..update(updates))._build();

  _$GoalModel._(
      {required this.goalId,
      required this.matchId,
      this.playerId,
      this.playerName,
      this.position,
      this.assistPlayerId,
      this.assistPlayerName,
      this.scoreTypeId,
      required this.isSecondaryTeam,
      required this.mins,
      required this.secondaryTeamName,
      this.scoreType,
      this.primaryGoalCount,
      this.secondaryGoalCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(goalId, r'GoalModel', 'goalId');
    BuiltValueNullFieldError.checkNotNull(matchId, r'GoalModel', 'matchId');
    BuiltValueNullFieldError.checkNotNull(
        isSecondaryTeam, r'GoalModel', 'isSecondaryTeam');
    BuiltValueNullFieldError.checkNotNull(mins, r'GoalModel', 'mins');
    BuiltValueNullFieldError.checkNotNull(
        secondaryTeamName, r'GoalModel', 'secondaryTeamName');
  }

  @override
  GoalModel rebuild(void Function(GoalModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalModelBuilder toBuilder() => new GoalModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoalModel &&
        goalId == other.goalId &&
        matchId == other.matchId &&
        playerId == other.playerId &&
        playerName == other.playerName &&
        position == other.position &&
        assistPlayerId == other.assistPlayerId &&
        assistPlayerName == other.assistPlayerName &&
        scoreTypeId == other.scoreTypeId &&
        isSecondaryTeam == other.isSecondaryTeam &&
        mins == other.mins &&
        secondaryTeamName == other.secondaryTeamName &&
        scoreType == other.scoreType &&
        primaryGoalCount == other.primaryGoalCount &&
        secondaryGoalCount == other.secondaryGoalCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, goalId.hashCode);
    _$hash = $jc(_$hash, matchId.hashCode);
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jc(_$hash, playerName.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, assistPlayerId.hashCode);
    _$hash = $jc(_$hash, assistPlayerName.hashCode);
    _$hash = $jc(_$hash, scoreTypeId.hashCode);
    _$hash = $jc(_$hash, isSecondaryTeam.hashCode);
    _$hash = $jc(_$hash, mins.hashCode);
    _$hash = $jc(_$hash, secondaryTeamName.hashCode);
    _$hash = $jc(_$hash, scoreType.hashCode);
    _$hash = $jc(_$hash, primaryGoalCount.hashCode);
    _$hash = $jc(_$hash, secondaryGoalCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GoalModel')
          ..add('goalId', goalId)
          ..add('matchId', matchId)
          ..add('playerId', playerId)
          ..add('playerName', playerName)
          ..add('position', position)
          ..add('assistPlayerId', assistPlayerId)
          ..add('assistPlayerName', assistPlayerName)
          ..add('scoreTypeId', scoreTypeId)
          ..add('isSecondaryTeam', isSecondaryTeam)
          ..add('mins', mins)
          ..add('secondaryTeamName', secondaryTeamName)
          ..add('scoreType', scoreType)
          ..add('primaryGoalCount', primaryGoalCount)
          ..add('secondaryGoalCount', secondaryGoalCount))
        .toString();
  }
}

class GoalModelBuilder implements Builder<GoalModel, GoalModelBuilder> {
  _$GoalModel? _$v;

  int? _goalId;
  int? get goalId => _$this._goalId;
  set goalId(int? goalId) => _$this._goalId = goalId;

  int? _matchId;
  int? get matchId => _$this._matchId;
  set matchId(int? matchId) => _$this._matchId = matchId;

  int? _playerId;
  int? get playerId => _$this._playerId;
  set playerId(int? playerId) => _$this._playerId = playerId;

  String? _playerName;
  String? get playerName => _$this._playerName;
  set playerName(String? playerName) => _$this._playerName = playerName;

  String? _position;
  String? get position => _$this._position;
  set position(String? position) => _$this._position = position;

  int? _assistPlayerId;
  int? get assistPlayerId => _$this._assistPlayerId;
  set assistPlayerId(int? assistPlayerId) =>
      _$this._assistPlayerId = assistPlayerId;

  String? _assistPlayerName;
  String? get assistPlayerName => _$this._assistPlayerName;
  set assistPlayerName(String? assistPlayerName) =>
      _$this._assistPlayerName = assistPlayerName;

  int? _scoreTypeId;
  int? get scoreTypeId => _$this._scoreTypeId;
  set scoreTypeId(int? scoreTypeId) => _$this._scoreTypeId = scoreTypeId;

  int? _isSecondaryTeam;
  int? get isSecondaryTeam => _$this._isSecondaryTeam;
  set isSecondaryTeam(int? isSecondaryTeam) =>
      _$this._isSecondaryTeam = isSecondaryTeam;

  int? _mins;
  int? get mins => _$this._mins;
  set mins(int? mins) => _$this._mins = mins;

  String? _secondaryTeamName;
  String? get secondaryTeamName => _$this._secondaryTeamName;
  set secondaryTeamName(String? secondaryTeamName) =>
      _$this._secondaryTeamName = secondaryTeamName;

  String? _scoreType;
  String? get scoreType => _$this._scoreType;
  set scoreType(String? scoreType) => _$this._scoreType = scoreType;

  int? _primaryGoalCount;
  int? get primaryGoalCount => _$this._primaryGoalCount;
  set primaryGoalCount(int? primaryGoalCount) =>
      _$this._primaryGoalCount = primaryGoalCount;

  int? _secondaryGoalCount;
  int? get secondaryGoalCount => _$this._secondaryGoalCount;
  set secondaryGoalCount(int? secondaryGoalCount) =>
      _$this._secondaryGoalCount = secondaryGoalCount;

  GoalModelBuilder();

  GoalModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _goalId = $v.goalId;
      _matchId = $v.matchId;
      _playerId = $v.playerId;
      _playerName = $v.playerName;
      _position = $v.position;
      _assistPlayerId = $v.assistPlayerId;
      _assistPlayerName = $v.assistPlayerName;
      _scoreTypeId = $v.scoreTypeId;
      _isSecondaryTeam = $v.isSecondaryTeam;
      _mins = $v.mins;
      _secondaryTeamName = $v.secondaryTeamName;
      _scoreType = $v.scoreType;
      _primaryGoalCount = $v.primaryGoalCount;
      _secondaryGoalCount = $v.secondaryGoalCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoalModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GoalModel;
  }

  @override
  void update(void Function(GoalModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GoalModel build() => _build();

  _$GoalModel _build() {
    final _$result = _$v ??
        new _$GoalModel._(
            goalId: BuiltValueNullFieldError.checkNotNull(
                goalId, r'GoalModel', 'goalId'),
            matchId: BuiltValueNullFieldError.checkNotNull(
                matchId, r'GoalModel', 'matchId'),
            playerId: playerId,
            playerName: playerName,
            position: position,
            assistPlayerId: assistPlayerId,
            assistPlayerName: assistPlayerName,
            scoreTypeId: scoreTypeId,
            isSecondaryTeam: BuiltValueNullFieldError.checkNotNull(
                isSecondaryTeam, r'GoalModel', 'isSecondaryTeam'),
            mins: BuiltValueNullFieldError.checkNotNull(
                mins, r'GoalModel', 'mins'),
            secondaryTeamName: BuiltValueNullFieldError.checkNotNull(
                secondaryTeamName, r'GoalModel', 'secondaryTeamName'),
            scoreType: scoreType,
            primaryGoalCount: primaryGoalCount,
            secondaryGoalCount: secondaryGoalCount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
