// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addPlayerToTeamRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddPlayerToTeamRequestModel>
    _$addPlayerToTeamRequestModelSerializer =
    new _$AddPlayerToTeamRequestModelSerializer();

class _$AddPlayerToTeamRequestModelSerializer
    implements StructuredSerializer<AddPlayerToTeamRequestModel> {
  @override
  final Iterable<Type> types = const [
    AddPlayerToTeamRequestModel,
    _$AddPlayerToTeamRequestModel
  ];
  @override
  final String wireName = 'AddPlayerToTeamRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AddPlayerToTeamRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'players',
      serializers.serialize(object.players,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  AddPlayerToTeamRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddPlayerToTeamRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'players':
          result.players.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$AddPlayerToTeamRequestModel extends AddPlayerToTeamRequestModel {
  @override
  final BuiltList<int> players;

  factory _$AddPlayerToTeamRequestModel(
          [void Function(AddPlayerToTeamRequestModelBuilder)? updates]) =>
      (new AddPlayerToTeamRequestModelBuilder()..update(updates))._build();

  _$AddPlayerToTeamRequestModel._({required this.players}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        players, r'AddPlayerToTeamRequestModel', 'players');
  }

  @override
  AddPlayerToTeamRequestModel rebuild(
          void Function(AddPlayerToTeamRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddPlayerToTeamRequestModelBuilder toBuilder() =>
      new AddPlayerToTeamRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddPlayerToTeamRequestModel && players == other.players;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, players.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddPlayerToTeamRequestModel')
          ..add('players', players))
        .toString();
  }
}

class AddPlayerToTeamRequestModelBuilder
    implements
        Builder<AddPlayerToTeamRequestModel,
            AddPlayerToTeamRequestModelBuilder> {
  _$AddPlayerToTeamRequestModel? _$v;

  ListBuilder<int>? _players;
  ListBuilder<int> get players => _$this._players ??= new ListBuilder<int>();
  set players(ListBuilder<int>? players) => _$this._players = players;

  AddPlayerToTeamRequestModelBuilder();

  AddPlayerToTeamRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _players = $v.players.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddPlayerToTeamRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddPlayerToTeamRequestModel;
  }

  @override
  void update(void Function(AddPlayerToTeamRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddPlayerToTeamRequestModel build() => _build();

  _$AddPlayerToTeamRequestModel _build() {
    _$AddPlayerToTeamRequestModel _$result;
    try {
      _$result =
          _$v ?? new _$AddPlayerToTeamRequestModel._(players: players.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'players';
        players.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AddPlayerToTeamRequestModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
