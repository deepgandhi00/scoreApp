// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Player> _$playerSerializer = new _$PlayerSerializer();

class _$PlayerSerializer implements StructuredSerializer<Player> {
  @override
  final Iterable<Type> types = const [Player, _$Player];
  @override
  final String wireName = 'Player';

  @override
  Iterable<Object?> serialize(Serializers serializers, Player object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'playerId',
      serializers.serialize(object.playerId,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.position;
    if (value != null) {
      result
        ..add('position')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.positionId;
    if (value != null) {
      result
        ..add('positionId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
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
  Player deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlayerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'playerId':
          result.playerId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'positionId':
          result.positionId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$Player extends Player {
  @override
  final String name;
  @override
  final String? position;
  @override
  final int playerId;
  @override
  final int? positionId;
  @override
  final String? type;
  @override
  final String? photo;
  @override
  final String? tagName;

  factory _$Player([void Function(PlayerBuilder)? updates]) =>
      (new PlayerBuilder()..update(updates))._build();

  _$Player._(
      {required this.name,
      this.position,
      required this.playerId,
      this.positionId,
      this.type,
      this.photo,
      this.tagName})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'Player', 'name');
    BuiltValueNullFieldError.checkNotNull(playerId, r'Player', 'playerId');
  }

  @override
  Player rebuild(void Function(PlayerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlayerBuilder toBuilder() => new PlayerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Player &&
        name == other.name &&
        position == other.position &&
        playerId == other.playerId &&
        positionId == other.positionId &&
        type == other.type &&
        photo == other.photo &&
        tagName == other.tagName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, photo.hashCode);
    _$hash = $jc(_$hash, tagName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Player')
          ..add('name', name)
          ..add('position', position)
          ..add('playerId', playerId)
          ..add('positionId', positionId)
          ..add('type', type)
          ..add('photo', photo)
          ..add('tagName', tagName))
        .toString();
  }
}

class PlayerBuilder implements Builder<Player, PlayerBuilder> {
  _$Player? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _position;
  String? get position => _$this._position;
  set position(String? position) => _$this._position = position;

  int? _playerId;
  int? get playerId => _$this._playerId;
  set playerId(int? playerId) => _$this._playerId = playerId;

  int? _positionId;
  int? get positionId => _$this._positionId;
  set positionId(int? positionId) => _$this._positionId = positionId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  String? _tagName;
  String? get tagName => _$this._tagName;
  set tagName(String? tagName) => _$this._tagName = tagName;

  PlayerBuilder();

  PlayerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _position = $v.position;
      _playerId = $v.playerId;
      _positionId = $v.positionId;
      _type = $v.type;
      _photo = $v.photo;
      _tagName = $v.tagName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Player other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Player;
  }

  @override
  void update(void Function(PlayerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Player build() => _build();

  _$Player _build() {
    final _$result = _$v ??
        new _$Player._(
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Player', 'name'),
            position: position,
            playerId: BuiltValueNullFieldError.checkNotNull(
                playerId, r'Player', 'playerId'),
            positionId: positionId,
            type: type,
            photo: photo,
            tagName: tagName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
