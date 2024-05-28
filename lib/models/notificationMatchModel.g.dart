// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationMatchModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NotificationMatchModel> _$notificationMatchModelSerializer =
    new _$NotificationMatchModelSerializer();

class _$NotificationMatchModelSerializer
    implements StructuredSerializer<NotificationMatchModel> {
  @override
  final Iterable<Type> types = const [
    NotificationMatchModel,
    _$NotificationMatchModel
  ];
  @override
  final String wireName = 'NotificationMatchModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, NotificationMatchModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'primaryTeamName',
      serializers.serialize(object.primaryTeamName,
          specifiedType: const FullType(String)),
      'secondaryGoalCount',
      serializers.serialize(object.secondaryGoalCount,
          specifiedType: const FullType(String)),
      'secondaryTeamName',
      serializers.serialize(object.secondaryTeamName,
          specifiedType: const FullType(String)),
      'timer',
      serializers.serialize(object.timer,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.mins;
    if (value != null) {
      result
        ..add('mins')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.progress;
    if (value != null) {
      result
        ..add('progress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.matchId;
    if (value != null) {
      result
        ..add('matchId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
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
    value = object.primaryTeamLogo;
    if (value != null) {
      result
        ..add('primaryTeamLogo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.primaryGoalCount;
    if (value != null) {
      result
        ..add('primaryGoalCount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assistPlayerName;
    if (value != null) {
      result
        ..add('assistPlayerName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.playerName;
    if (value != null) {
      result
        ..add('playerName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.scoreType;
    if (value != null) {
      result
        ..add('scoreType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isSecondaryTeam;
    if (value != null) {
      result
        ..add('isSecondaryTeam')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NotificationMatchModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationMatchModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'primaryTeamName':
          result.primaryTeamName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'secondaryGoalCount':
          result.secondaryGoalCount = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'secondaryTeamName':
          result.secondaryTeamName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'timer':
          result.timer = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'mins':
          result.mins = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'progress':
          result.progress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'matchId':
          result.matchId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'secondaryTeamLogo':
          result.secondaryTeamLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'primaryTeamLogo':
          result.primaryTeamLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'primaryGoalCount':
          result.primaryGoalCount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assistPlayerName':
          result.assistPlayerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'playerName':
          result.playerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'scoreType':
          result.scoreType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isSecondaryTeam':
          result.isSecondaryTeam = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationMatchModel extends NotificationMatchModel {
  @override
  final String date;
  @override
  final String primaryTeamName;
  @override
  final String secondaryGoalCount;
  @override
  final String secondaryTeamName;
  @override
  final String timer;
  @override
  final String? mins;
  @override
  final String? progress;
  @override
  final String? matchId;
  @override
  final String? status;
  @override
  final String? secondaryTeamLogo;
  @override
  final String? primaryTeamLogo;
  @override
  final String? primaryGoalCount;
  @override
  final String? assistPlayerName;
  @override
  final String? playerName;
  @override
  final String? scoreType;
  @override
  final String? isSecondaryTeam;

  factory _$NotificationMatchModel(
          [void Function(NotificationMatchModelBuilder)? updates]) =>
      (new NotificationMatchModelBuilder()..update(updates))._build();

  _$NotificationMatchModel._(
      {required this.date,
      required this.primaryTeamName,
      required this.secondaryGoalCount,
      required this.secondaryTeamName,
      required this.timer,
      this.mins,
      this.progress,
      this.matchId,
      this.status,
      this.secondaryTeamLogo,
      this.primaryTeamLogo,
      this.primaryGoalCount,
      this.assistPlayerName,
      this.playerName,
      this.scoreType,
      this.isSecondaryTeam})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        date, r'NotificationMatchModel', 'date');
    BuiltValueNullFieldError.checkNotNull(
        primaryTeamName, r'NotificationMatchModel', 'primaryTeamName');
    BuiltValueNullFieldError.checkNotNull(
        secondaryGoalCount, r'NotificationMatchModel', 'secondaryGoalCount');
    BuiltValueNullFieldError.checkNotNull(
        secondaryTeamName, r'NotificationMatchModel', 'secondaryTeamName');
    BuiltValueNullFieldError.checkNotNull(
        timer, r'NotificationMatchModel', 'timer');
  }

  @override
  NotificationMatchModel rebuild(
          void Function(NotificationMatchModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationMatchModelBuilder toBuilder() =>
      new NotificationMatchModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationMatchModel &&
        date == other.date &&
        primaryTeamName == other.primaryTeamName &&
        secondaryGoalCount == other.secondaryGoalCount &&
        secondaryTeamName == other.secondaryTeamName &&
        timer == other.timer &&
        mins == other.mins &&
        progress == other.progress &&
        matchId == other.matchId &&
        status == other.status &&
        secondaryTeamLogo == other.secondaryTeamLogo &&
        primaryTeamLogo == other.primaryTeamLogo &&
        primaryGoalCount == other.primaryGoalCount &&
        assistPlayerName == other.assistPlayerName &&
        playerName == other.playerName &&
        scoreType == other.scoreType &&
        isSecondaryTeam == other.isSecondaryTeam;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, primaryTeamName.hashCode);
    _$hash = $jc(_$hash, secondaryGoalCount.hashCode);
    _$hash = $jc(_$hash, secondaryTeamName.hashCode);
    _$hash = $jc(_$hash, timer.hashCode);
    _$hash = $jc(_$hash, mins.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jc(_$hash, matchId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, secondaryTeamLogo.hashCode);
    _$hash = $jc(_$hash, primaryTeamLogo.hashCode);
    _$hash = $jc(_$hash, primaryGoalCount.hashCode);
    _$hash = $jc(_$hash, assistPlayerName.hashCode);
    _$hash = $jc(_$hash, playerName.hashCode);
    _$hash = $jc(_$hash, scoreType.hashCode);
    _$hash = $jc(_$hash, isSecondaryTeam.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationMatchModel')
          ..add('date', date)
          ..add('primaryTeamName', primaryTeamName)
          ..add('secondaryGoalCount', secondaryGoalCount)
          ..add('secondaryTeamName', secondaryTeamName)
          ..add('timer', timer)
          ..add('mins', mins)
          ..add('progress', progress)
          ..add('matchId', matchId)
          ..add('status', status)
          ..add('secondaryTeamLogo', secondaryTeamLogo)
          ..add('primaryTeamLogo', primaryTeamLogo)
          ..add('primaryGoalCount', primaryGoalCount)
          ..add('assistPlayerName', assistPlayerName)
          ..add('playerName', playerName)
          ..add('scoreType', scoreType)
          ..add('isSecondaryTeam', isSecondaryTeam))
        .toString();
  }
}

class NotificationMatchModelBuilder
    implements Builder<NotificationMatchModel, NotificationMatchModelBuilder> {
  _$NotificationMatchModel? _$v;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _primaryTeamName;
  String? get primaryTeamName => _$this._primaryTeamName;
  set primaryTeamName(String? primaryTeamName) =>
      _$this._primaryTeamName = primaryTeamName;

  String? _secondaryGoalCount;
  String? get secondaryGoalCount => _$this._secondaryGoalCount;
  set secondaryGoalCount(String? secondaryGoalCount) =>
      _$this._secondaryGoalCount = secondaryGoalCount;

  String? _secondaryTeamName;
  String? get secondaryTeamName => _$this._secondaryTeamName;
  set secondaryTeamName(String? secondaryTeamName) =>
      _$this._secondaryTeamName = secondaryTeamName;

  String? _timer;
  String? get timer => _$this._timer;
  set timer(String? timer) => _$this._timer = timer;

  String? _mins;
  String? get mins => _$this._mins;
  set mins(String? mins) => _$this._mins = mins;

  String? _progress;
  String? get progress => _$this._progress;
  set progress(String? progress) => _$this._progress = progress;

  String? _matchId;
  String? get matchId => _$this._matchId;
  set matchId(String? matchId) => _$this._matchId = matchId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _secondaryTeamLogo;
  String? get secondaryTeamLogo => _$this._secondaryTeamLogo;
  set secondaryTeamLogo(String? secondaryTeamLogo) =>
      _$this._secondaryTeamLogo = secondaryTeamLogo;

  String? _primaryTeamLogo;
  String? get primaryTeamLogo => _$this._primaryTeamLogo;
  set primaryTeamLogo(String? primaryTeamLogo) =>
      _$this._primaryTeamLogo = primaryTeamLogo;

  String? _primaryGoalCount;
  String? get primaryGoalCount => _$this._primaryGoalCount;
  set primaryGoalCount(String? primaryGoalCount) =>
      _$this._primaryGoalCount = primaryGoalCount;

  String? _assistPlayerName;
  String? get assistPlayerName => _$this._assistPlayerName;
  set assistPlayerName(String? assistPlayerName) =>
      _$this._assistPlayerName = assistPlayerName;

  String? _playerName;
  String? get playerName => _$this._playerName;
  set playerName(String? playerName) => _$this._playerName = playerName;

  String? _scoreType;
  String? get scoreType => _$this._scoreType;
  set scoreType(String? scoreType) => _$this._scoreType = scoreType;

  String? _isSecondaryTeam;
  String? get isSecondaryTeam => _$this._isSecondaryTeam;
  set isSecondaryTeam(String? isSecondaryTeam) =>
      _$this._isSecondaryTeam = isSecondaryTeam;

  NotificationMatchModelBuilder();

  NotificationMatchModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _primaryTeamName = $v.primaryTeamName;
      _secondaryGoalCount = $v.secondaryGoalCount;
      _secondaryTeamName = $v.secondaryTeamName;
      _timer = $v.timer;
      _mins = $v.mins;
      _progress = $v.progress;
      _matchId = $v.matchId;
      _status = $v.status;
      _secondaryTeamLogo = $v.secondaryTeamLogo;
      _primaryTeamLogo = $v.primaryTeamLogo;
      _primaryGoalCount = $v.primaryGoalCount;
      _assistPlayerName = $v.assistPlayerName;
      _playerName = $v.playerName;
      _scoreType = $v.scoreType;
      _isSecondaryTeam = $v.isSecondaryTeam;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationMatchModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NotificationMatchModel;
  }

  @override
  void update(void Function(NotificationMatchModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationMatchModel build() => _build();

  _$NotificationMatchModel _build() {
    final _$result = _$v ??
        new _$NotificationMatchModel._(
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'NotificationMatchModel', 'date'),
            primaryTeamName: BuiltValueNullFieldError.checkNotNull(
                primaryTeamName, r'NotificationMatchModel', 'primaryTeamName'),
            secondaryGoalCount: BuiltValueNullFieldError.checkNotNull(
                secondaryGoalCount,
                r'NotificationMatchModel',
                'secondaryGoalCount'),
            secondaryTeamName: BuiltValueNullFieldError.checkNotNull(
                secondaryTeamName,
                r'NotificationMatchModel',
                'secondaryTeamName'),
            timer: BuiltValueNullFieldError.checkNotNull(
                timer, r'NotificationMatchModel', 'timer'),
            mins: mins,
            progress: progress,
            matchId: matchId,
            status: status,
            secondaryTeamLogo: secondaryTeamLogo,
            primaryTeamLogo: primaryTeamLogo,
            primaryGoalCount: primaryGoalCount,
            assistPlayerName: assistPlayerName,
            playerName: playerName,
            scoreType: scoreType,
            isSecondaryTeam: isSecondaryTeam);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
