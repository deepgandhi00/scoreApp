// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PlayerListModel> _$playerListModelSerializer =
    new _$PlayerListModelSerializer();

class _$PlayerListModelSerializer
    implements StructuredSerializer<PlayerListModel> {
  @override
  final Iterable<Type> types = const [PlayerListModel, _$PlayerListModel];
  @override
  final String wireName = 'PlayerListModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, PlayerListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Player)])),
    ];

    return result;
  }

  @override
  PlayerListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlayerListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Player)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$PlayerListModel extends PlayerListModel {
  @override
  final BuiltList<Player> data;

  factory _$PlayerListModel([void Function(PlayerListModelBuilder)? updates]) =>
      (new PlayerListModelBuilder()..update(updates))._build();

  _$PlayerListModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'PlayerListModel', 'data');
  }

  @override
  PlayerListModel rebuild(void Function(PlayerListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlayerListModelBuilder toBuilder() =>
      new PlayerListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlayerListModel && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlayerListModel')..add('data', data))
        .toString();
  }
}

class PlayerListModelBuilder
    implements Builder<PlayerListModel, PlayerListModelBuilder> {
  _$PlayerListModel? _$v;

  ListBuilder<Player>? _data;
  ListBuilder<Player> get data => _$this._data ??= new ListBuilder<Player>();
  set data(ListBuilder<Player>? data) => _$this._data = data;

  PlayerListModelBuilder();

  PlayerListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlayerListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PlayerListModel;
  }

  @override
  void update(void Function(PlayerListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlayerListModel build() => _build();

  _$PlayerListModel _build() {
    _$PlayerListModel _$result;
    try {
      _$result = _$v ?? new _$PlayerListModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PlayerListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
