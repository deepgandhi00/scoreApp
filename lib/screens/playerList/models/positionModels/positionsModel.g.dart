// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positionsModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PositionsModel> _$positionsModelSerializer =
    new _$PositionsModelSerializer();

class _$PositionsModelSerializer
    implements StructuredSerializer<PositionsModel> {
  @override
  final Iterable<Type> types = const [PositionsModel, _$PositionsModel];
  @override
  final String wireName = 'PositionsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, PositionsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.position_id;
    if (value != null) {
      result
        ..add('position_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  PositionsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PositionsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'position_id':
          result.position_id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PositionsModel extends PositionsModel {
  @override
  final int? position_id;
  @override
  final String name;

  factory _$PositionsModel([void Function(PositionsModelBuilder)? updates]) =>
      (new PositionsModelBuilder()..update(updates))._build();

  _$PositionsModel._({this.position_id, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'PositionsModel', 'name');
  }

  @override
  PositionsModel rebuild(void Function(PositionsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionsModelBuilder toBuilder() =>
      new PositionsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PositionsModel &&
        position_id == other.position_id &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, position_id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PositionsModel')
          ..add('position_id', position_id)
          ..add('name', name))
        .toString();
  }
}

class PositionsModelBuilder
    implements Builder<PositionsModel, PositionsModelBuilder> {
  _$PositionsModel? _$v;

  int? _position_id;
  int? get position_id => _$this._position_id;
  set position_id(int? position_id) => _$this._position_id = position_id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  PositionsModelBuilder();

  PositionsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _position_id = $v.position_id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PositionsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PositionsModel;
  }

  @override
  void update(void Function(PositionsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PositionsModel build() => _build();

  _$PositionsModel _build() {
    final _$result = _$v ??
        new _$PositionsModel._(
            position_id: position_id,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'PositionsModel', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
