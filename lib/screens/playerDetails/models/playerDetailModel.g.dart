// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerDetailModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PlayerDetailModel> _$playerDetailModelSerializer =
    new _$PlayerDetailModelSerializer();

class _$PlayerDetailModelSerializer
    implements StructuredSerializer<PlayerDetailModel> {
  @override
  final Iterable<Type> types = const [PlayerDetailModel, _$PlayerDetailModel];
  @override
  final String wireName = 'PlayerDetailModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, PlayerDetailModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'playerId',
      serializers.serialize(object.playerId,
          specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'teams',
      serializers.serialize(object.teams,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TeamModel)])),
      'matchesCount',
      serializers.serialize(object.matchesCount,
          specifiedType: const FullType(int)),
      'goalsCount',
      serializers.serialize(object.goalsCount,
          specifiedType: const FullType(int)),
      'assistsCount',
      serializers.serialize(object.assistsCount,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.positionId;
    if (value != null) {
      result
        ..add('positionId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.position;
    if (value != null) {
      result
        ..add('position')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photo;
    if (value != null) {
      result
        ..add('photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tagName;
    if (value != null) {
      result
        ..add('tagName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PlayerDetailModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlayerDetailModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'playerId':
          result.playerId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'positionId':
          result.positionId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'teams':
          result.teams.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TeamModel)]))!
              as BuiltList<Object?>);
          break;
        case 'matchesCount':
          result.matchesCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'goalsCount':
          result.goalsCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'assistsCount':
          result.assistsCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'photo':
          result.photo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tagName':
          result.tagName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$PlayerDetailModel extends PlayerDetailModel {
  @override
  final int playerId;
  @override
  final String name;
  @override
  final int? positionId;
  @override
  final String? position;
  @override
  final BuiltList<TeamModel> teams;
  @override
  final int matchesCount;
  @override
  final int goalsCount;
  @override
  final int assistsCount;
  @override
  final String? photo;
  @override
  final String? tagName;

  factory _$PlayerDetailModel(
          [void Function(PlayerDetailModelBuilder)? updates]) =>
      (new PlayerDetailModelBuilder()..update(updates))._build();

  _$PlayerDetailModel._(
      {required this.playerId,
      required this.name,
      this.positionId,
      this.position,
      required this.teams,
      required this.matchesCount,
      required this.goalsCount,
      required this.assistsCount,
      this.photo,
      this.tagName})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        playerId, r'PlayerDetailModel', 'playerId');
    BuiltValueNullFieldError.checkNotNull(name, r'PlayerDetailModel', 'name');
    BuiltValueNullFieldError.checkNotNull(teams, r'PlayerDetailModel', 'teams');
    BuiltValueNullFieldError.checkNotNull(
        matchesCount, r'PlayerDetailModel', 'matchesCount');
    BuiltValueNullFieldError.checkNotNull(
        goalsCount, r'PlayerDetailModel', 'goalsCount');
    BuiltValueNullFieldError.checkNotNull(
        assistsCount, r'PlayerDetailModel', 'assistsCount');
  }

  @override
  PlayerDetailModel rebuild(void Function(PlayerDetailModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlayerDetailModelBuilder toBuilder() =>
      new PlayerDetailModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlayerDetailModel &&
        playerId == other.playerId &&
        name == other.name &&
        positionId == other.positionId &&
        position == other.position &&
        teams == other.teams &&
        matchesCount == other.matchesCount &&
        goalsCount == other.goalsCount &&
        assistsCount == other.assistsCount &&
        photo == other.photo &&
        tagName == other.tagName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, teams.hashCode);
    _$hash = $jc(_$hash, matchesCount.hashCode);
    _$hash = $jc(_$hash, goalsCount.hashCode);
    _$hash = $jc(_$hash, assistsCount.hashCode);
    _$hash = $jc(_$hash, photo.hashCode);
    _$hash = $jc(_$hash, tagName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlayerDetailModel')
          ..add('playerId', playerId)
          ..add('name', name)
          ..add('positionId', positionId)
          ..add('position', position)
          ..add('teams', teams)
          ..add('matchesCount', matchesCount)
          ..add('goalsCount', goalsCount)
          ..add('assistsCount', assistsCount)
          ..add('photo', photo)
          ..add('tagName', tagName))
        .toString();
  }
}

class PlayerDetailModelBuilder
    implements Builder<PlayerDetailModel, PlayerDetailModelBuilder> {
  _$PlayerDetailModel? _$v;

  int? _playerId;
  int? get playerId => _$this._playerId;
  set playerId(int? playerId) => _$this._playerId = playerId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _positionId;
  int? get positionId => _$this._positionId;
  set positionId(int? positionId) => _$this._positionId = positionId;

  String? _position;
  String? get position => _$this._position;
  set position(String? position) => _$this._position = position;

  ListBuilder<TeamModel>? _teams;
  ListBuilder<TeamModel> get teams =>
      _$this._teams ??= new ListBuilder<TeamModel>();
  set teams(ListBuilder<TeamModel>? teams) => _$this._teams = teams;

  int? _matchesCount;
  int? get matchesCount => _$this._matchesCount;
  set matchesCount(int? matchesCount) => _$this._matchesCount = matchesCount;

  int? _goalsCount;
  int? get goalsCount => _$this._goalsCount;
  set goalsCount(int? goalsCount) => _$this._goalsCount = goalsCount;

  int? _assistsCount;
  int? get assistsCount => _$this._assistsCount;
  set assistsCount(int? assistsCount) => _$this._assistsCount = assistsCount;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  String? _tagName;
  String? get tagName => _$this._tagName;
  set tagName(String? tagName) => _$this._tagName = tagName;

  PlayerDetailModelBuilder();

  PlayerDetailModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _playerId = $v.playerId;
      _name = $v.name;
      _positionId = $v.positionId;
      _position = $v.position;
      _teams = $v.teams.toBuilder();
      _matchesCount = $v.matchesCount;
      _goalsCount = $v.goalsCount;
      _assistsCount = $v.assistsCount;
      _photo = $v.photo;
      _tagName = $v.tagName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlayerDetailModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PlayerDetailModel;
  }

  @override
  void update(void Function(PlayerDetailModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlayerDetailModel build() => _build();

  _$PlayerDetailModel _build() {
    _$PlayerDetailModel _$result;
    try {
      _$result = _$v ??
          new _$PlayerDetailModel._(
              playerId: BuiltValueNullFieldError.checkNotNull(
                  playerId, r'PlayerDetailModel', 'playerId'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'PlayerDetailModel', 'name'),
              positionId: positionId,
              position: position,
              teams: teams.build(),
              matchesCount: BuiltValueNullFieldError.checkNotNull(
                  matchesCount, r'PlayerDetailModel', 'matchesCount'),
              goalsCount: BuiltValueNullFieldError.checkNotNull(
                  goalsCount, r'PlayerDetailModel', 'goalsCount'),
              assistsCount: BuiltValueNullFieldError.checkNotNull(
                  assistsCount, r'PlayerDetailModel', 'assistsCount'),
              photo: photo,
              tagName: tagName);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'teams';
        teams.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PlayerDetailModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
