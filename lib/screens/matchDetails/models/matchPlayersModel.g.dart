// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchPlayersModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MatchPlayersModel> _$matchPlayersModelSerializer =
    new _$MatchPlayersModelSerializer();

class _$MatchPlayersModelSerializer
    implements StructuredSerializer<MatchPlayersModel> {
  @override
  final Iterable<Type> types = const [MatchPlayersModel, _$MatchPlayersModel];
  @override
  final String wireName = 'MatchPlayersModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, MatchPlayersModel object,
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
  MatchPlayersModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MatchPlayersModelBuilder();

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

class _$MatchPlayersModel extends MatchPlayersModel {
  @override
  final BuiltList<Player> data;

  factory _$MatchPlayersModel(
          [void Function(MatchPlayersModelBuilder)? updates]) =>
      (new MatchPlayersModelBuilder()..update(updates))._build();

  _$MatchPlayersModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'MatchPlayersModel', 'data');
  }

  @override
  MatchPlayersModel rebuild(void Function(MatchPlayersModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MatchPlayersModelBuilder toBuilder() =>
      new MatchPlayersModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MatchPlayersModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'MatchPlayersModel')
          ..add('data', data))
        .toString();
  }
}

class MatchPlayersModelBuilder
    implements Builder<MatchPlayersModel, MatchPlayersModelBuilder> {
  _$MatchPlayersModel? _$v;

  ListBuilder<Player>? _data;
  ListBuilder<Player> get data => _$this._data ??= new ListBuilder<Player>();
  set data(ListBuilder<Player>? data) => _$this._data = data;

  MatchPlayersModelBuilder();

  MatchPlayersModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MatchPlayersModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MatchPlayersModel;
  }

  @override
  void update(void Function(MatchPlayersModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MatchPlayersModel build() => _build();

  _$MatchPlayersModel _build() {
    _$MatchPlayersModel _$result;
    try {
      _$result = _$v ?? new _$MatchPlayersModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MatchPlayersModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
