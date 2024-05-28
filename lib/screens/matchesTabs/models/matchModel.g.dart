// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MatchModel> _$matchModelSerializer = new _$MatchModelSerializer();

class _$MatchModelSerializer implements StructuredSerializer<MatchModel> {
  @override
  final Iterable<Type> types = const [MatchModel, _$MatchModel];
  @override
  final String wireName = 'MatchModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, MatchModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'matchId',
      serializers.serialize(object.matchId, specifiedType: const FullType(int)),
      'primaryTeamId',
      serializers.serialize(object.primaryTeamId,
          specifiedType: const FullType(int)),
      'primaryTeamName',
      serializers.serialize(object.primaryTeamName,
          specifiedType: const FullType(String)),
      'secondaryTeamName',
      serializers.serialize(object.secondaryTeamName,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(MatchStatusEnum)),
      'primaryTeamGoals',
      serializers.serialize(object.primaryTeamGoals,
          specifiedType: const FullType(int)),
      'secondaryTeamGoals',
      serializers.serialize(object.secondaryTeamGoals,
          specifiedType: const FullType(int)),
      'players',
      serializers.serialize(object.players,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Player)])),
      'goals',
      serializers.serialize(object.goals,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GoalModel)])),
    ];
    Object? value;
    value = object.primaryTeamLogo;
    if (value != null) {
      result
        ..add('primaryTeamLogo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.secondaryTeamLogo;
    if (value != null) {
      result
        ..add('secondaryTeamLogo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timer;
    if (value != null) {
      result
        ..add('timer')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.progress;
    if (value != null) {
      result
        ..add('progress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(MatchStatusEnum)));
    }
    value = object.isPublic;
    if (value != null) {
      result
        ..add('isPublic')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.kickOffTime;
    if (value != null) {
      result
        ..add('kickOffTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.league;
    if (value != null) {
      result
        ..add('league')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  MatchModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MatchModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'matchId':
          result.matchId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'primaryTeamId':
          result.primaryTeamId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'primaryTeamName':
          result.primaryTeamName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'primaryTeamLogo':
          result.primaryTeamLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'secondaryTeamName':
          result.secondaryTeamName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'secondaryTeamLogo':
          result.secondaryTeamLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(MatchStatusEnum))!
              as MatchStatusEnum;
          break;
        case 'primaryTeamGoals':
          result.primaryTeamGoals = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'secondaryTeamGoals':
          result.secondaryTeamGoals = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'timer':
          result.timer = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'progress':
          result.progress = serializers.deserialize(value,
                  specifiedType: const FullType(MatchStatusEnum))
              as MatchStatusEnum?;
          break;
        case 'players':
          result.players.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Player)]))!
              as BuiltList<Object?>);
          break;
        case 'goals':
          result.goals.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GoalModel)]))!
              as BuiltList<Object?>);
          break;
        case 'isPublic':
          result.isPublic = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'kickOffTime':
          result.kickOffTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'league':
          result.league = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$MatchModel extends MatchModel {
  @override
  final int matchId;
  @override
  final int primaryTeamId;
  @override
  final String primaryTeamName;
  @override
  final String? primaryTeamLogo;
  @override
  final String secondaryTeamName;
  @override
  final String? secondaryTeamLogo;
  @override
  final String? location;
  @override
  final String date;
  @override
  final MatchStatusEnum status;
  @override
  final int primaryTeamGoals;
  @override
  final int secondaryTeamGoals;
  @override
  final int? timer;
  @override
  final MatchStatusEnum? progress;
  @override
  final BuiltList<Player> players;
  @override
  final BuiltList<GoalModel> goals;
  @override
  final int? isPublic;
  @override
  final bool? owner;
  @override
  final String? kickOffTime;
  @override
  final String? league;

  factory _$MatchModel([void Function(MatchModelBuilder)? updates]) =>
      (new MatchModelBuilder()..update(updates))._build();

  _$MatchModel._(
      {required this.matchId,
      required this.primaryTeamId,
      required this.primaryTeamName,
      this.primaryTeamLogo,
      required this.secondaryTeamName,
      this.secondaryTeamLogo,
      this.location,
      required this.date,
      required this.status,
      required this.primaryTeamGoals,
      required this.secondaryTeamGoals,
      this.timer,
      this.progress,
      required this.players,
      required this.goals,
      this.isPublic,
      this.owner,
      this.kickOffTime,
      this.league})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(matchId, r'MatchModel', 'matchId');
    BuiltValueNullFieldError.checkNotNull(
        primaryTeamId, r'MatchModel', 'primaryTeamId');
    BuiltValueNullFieldError.checkNotNull(
        primaryTeamName, r'MatchModel', 'primaryTeamName');
    BuiltValueNullFieldError.checkNotNull(
        secondaryTeamName, r'MatchModel', 'secondaryTeamName');
    BuiltValueNullFieldError.checkNotNull(date, r'MatchModel', 'date');
    BuiltValueNullFieldError.checkNotNull(status, r'MatchModel', 'status');
    BuiltValueNullFieldError.checkNotNull(
        primaryTeamGoals, r'MatchModel', 'primaryTeamGoals');
    BuiltValueNullFieldError.checkNotNull(
        secondaryTeamGoals, r'MatchModel', 'secondaryTeamGoals');
    BuiltValueNullFieldError.checkNotNull(players, r'MatchModel', 'players');
    BuiltValueNullFieldError.checkNotNull(goals, r'MatchModel', 'goals');
  }

  @override
  MatchModel rebuild(void Function(MatchModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MatchModelBuilder toBuilder() => new MatchModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MatchModel &&
        matchId == other.matchId &&
        primaryTeamId == other.primaryTeamId &&
        primaryTeamName == other.primaryTeamName &&
        primaryTeamLogo == other.primaryTeamLogo &&
        secondaryTeamName == other.secondaryTeamName &&
        secondaryTeamLogo == other.secondaryTeamLogo &&
        location == other.location &&
        date == other.date &&
        status == other.status &&
        primaryTeamGoals == other.primaryTeamGoals &&
        secondaryTeamGoals == other.secondaryTeamGoals &&
        timer == other.timer &&
        progress == other.progress &&
        players == other.players &&
        goals == other.goals &&
        isPublic == other.isPublic &&
        owner == other.owner &&
        kickOffTime == other.kickOffTime &&
        league == other.league;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, matchId.hashCode);
    _$hash = $jc(_$hash, primaryTeamId.hashCode);
    _$hash = $jc(_$hash, primaryTeamName.hashCode);
    _$hash = $jc(_$hash, primaryTeamLogo.hashCode);
    _$hash = $jc(_$hash, secondaryTeamName.hashCode);
    _$hash = $jc(_$hash, secondaryTeamLogo.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, primaryTeamGoals.hashCode);
    _$hash = $jc(_$hash, secondaryTeamGoals.hashCode);
    _$hash = $jc(_$hash, timer.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jc(_$hash, players.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jc(_$hash, isPublic.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, kickOffTime.hashCode);
    _$hash = $jc(_$hash, league.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MatchModel')
          ..add('matchId', matchId)
          ..add('primaryTeamId', primaryTeamId)
          ..add('primaryTeamName', primaryTeamName)
          ..add('primaryTeamLogo', primaryTeamLogo)
          ..add('secondaryTeamName', secondaryTeamName)
          ..add('secondaryTeamLogo', secondaryTeamLogo)
          ..add('location', location)
          ..add('date', date)
          ..add('status', status)
          ..add('primaryTeamGoals', primaryTeamGoals)
          ..add('secondaryTeamGoals', secondaryTeamGoals)
          ..add('timer', timer)
          ..add('progress', progress)
          ..add('players', players)
          ..add('goals', goals)
          ..add('isPublic', isPublic)
          ..add('owner', owner)
          ..add('kickOffTime', kickOffTime)
          ..add('league', league))
        .toString();
  }
}

class MatchModelBuilder implements Builder<MatchModel, MatchModelBuilder> {
  _$MatchModel? _$v;

  int? _matchId;
  int? get matchId => _$this._matchId;
  set matchId(int? matchId) => _$this._matchId = matchId;

  int? _primaryTeamId;
  int? get primaryTeamId => _$this._primaryTeamId;
  set primaryTeamId(int? primaryTeamId) =>
      _$this._primaryTeamId = primaryTeamId;

  String? _primaryTeamName;
  String? get primaryTeamName => _$this._primaryTeamName;
  set primaryTeamName(String? primaryTeamName) =>
      _$this._primaryTeamName = primaryTeamName;

  String? _primaryTeamLogo;
  String? get primaryTeamLogo => _$this._primaryTeamLogo;
  set primaryTeamLogo(String? primaryTeamLogo) =>
      _$this._primaryTeamLogo = primaryTeamLogo;

  String? _secondaryTeamName;
  String? get secondaryTeamName => _$this._secondaryTeamName;
  set secondaryTeamName(String? secondaryTeamName) =>
      _$this._secondaryTeamName = secondaryTeamName;

  String? _secondaryTeamLogo;
  String? get secondaryTeamLogo => _$this._secondaryTeamLogo;
  set secondaryTeamLogo(String? secondaryTeamLogo) =>
      _$this._secondaryTeamLogo = secondaryTeamLogo;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  MatchStatusEnum? _status;
  MatchStatusEnum? get status => _$this._status;
  set status(MatchStatusEnum? status) => _$this._status = status;

  int? _primaryTeamGoals;
  int? get primaryTeamGoals => _$this._primaryTeamGoals;
  set primaryTeamGoals(int? primaryTeamGoals) =>
      _$this._primaryTeamGoals = primaryTeamGoals;

  int? _secondaryTeamGoals;
  int? get secondaryTeamGoals => _$this._secondaryTeamGoals;
  set secondaryTeamGoals(int? secondaryTeamGoals) =>
      _$this._secondaryTeamGoals = secondaryTeamGoals;

  int? _timer;
  int? get timer => _$this._timer;
  set timer(int? timer) => _$this._timer = timer;

  MatchStatusEnum? _progress;
  MatchStatusEnum? get progress => _$this._progress;
  set progress(MatchStatusEnum? progress) => _$this._progress = progress;

  ListBuilder<Player>? _players;
  ListBuilder<Player> get players =>
      _$this._players ??= new ListBuilder<Player>();
  set players(ListBuilder<Player>? players) => _$this._players = players;

  ListBuilder<GoalModel>? _goals;
  ListBuilder<GoalModel> get goals =>
      _$this._goals ??= new ListBuilder<GoalModel>();
  set goals(ListBuilder<GoalModel>? goals) => _$this._goals = goals;

  int? _isPublic;
  int? get isPublic => _$this._isPublic;
  set isPublic(int? isPublic) => _$this._isPublic = isPublic;

  bool? _owner;
  bool? get owner => _$this._owner;
  set owner(bool? owner) => _$this._owner = owner;

  String? _kickOffTime;
  String? get kickOffTime => _$this._kickOffTime;
  set kickOffTime(String? kickOffTime) => _$this._kickOffTime = kickOffTime;

  String? _league;
  String? get league => _$this._league;
  set league(String? league) => _$this._league = league;

  MatchModelBuilder();

  MatchModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _matchId = $v.matchId;
      _primaryTeamId = $v.primaryTeamId;
      _primaryTeamName = $v.primaryTeamName;
      _primaryTeamLogo = $v.primaryTeamLogo;
      _secondaryTeamName = $v.secondaryTeamName;
      _secondaryTeamLogo = $v.secondaryTeamLogo;
      _location = $v.location;
      _date = $v.date;
      _status = $v.status;
      _primaryTeamGoals = $v.primaryTeamGoals;
      _secondaryTeamGoals = $v.secondaryTeamGoals;
      _timer = $v.timer;
      _progress = $v.progress;
      _players = $v.players.toBuilder();
      _goals = $v.goals.toBuilder();
      _isPublic = $v.isPublic;
      _owner = $v.owner;
      _kickOffTime = $v.kickOffTime;
      _league = $v.league;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MatchModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MatchModel;
  }

  @override
  void update(void Function(MatchModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MatchModel build() => _build();

  _$MatchModel _build() {
    _$MatchModel _$result;
    try {
      _$result = _$v ??
          new _$MatchModel._(
              matchId: BuiltValueNullFieldError.checkNotNull(
                  matchId, r'MatchModel', 'matchId'),
              primaryTeamId: BuiltValueNullFieldError.checkNotNull(
                  primaryTeamId, r'MatchModel', 'primaryTeamId'),
              primaryTeamName: BuiltValueNullFieldError.checkNotNull(
                  primaryTeamName, r'MatchModel', 'primaryTeamName'),
              primaryTeamLogo: primaryTeamLogo,
              secondaryTeamName: BuiltValueNullFieldError.checkNotNull(
                  secondaryTeamName, r'MatchModel', 'secondaryTeamName'),
              secondaryTeamLogo: secondaryTeamLogo,
              location: location,
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'MatchModel', 'date'),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'MatchModel', 'status'),
              primaryTeamGoals: BuiltValueNullFieldError.checkNotNull(
                  primaryTeamGoals, r'MatchModel', 'primaryTeamGoals'),
              secondaryTeamGoals: BuiltValueNullFieldError.checkNotNull(
                  secondaryTeamGoals, r'MatchModel', 'secondaryTeamGoals'),
              timer: timer,
              progress: progress,
              players: players.build(),
              goals: goals.build(),
              isPublic: isPublic,
              owner: owner,
              kickOffTime: kickOffTime,
              league: league);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'players';
        players.build();
        _$failedField = 'goals';
        goals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MatchModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
