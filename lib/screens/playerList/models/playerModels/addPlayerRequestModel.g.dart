// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addPlayerRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddPlayerRequestModel> _$addPlayerRequestModelSerializer =
    new _$AddPlayerRequestModelSerializer();

class _$AddPlayerRequestModelSerializer
    implements StructuredSerializer<AddPlayerRequestModel> {
  @override
  final Iterable<Type> types = const [
    AddPlayerRequestModel,
    _$AddPlayerRequestModel
  ];
  @override
  final String wireName = 'AddPlayerRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AddPlayerRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.positionId;
    if (value != null) {
      result
        ..add('positionId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.initialTeamId;
    if (value != null) {
      result
        ..add('initialTeamId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  AddPlayerRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddPlayerRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'positionId':
          result.positionId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'initialTeamId':
          result.initialTeamId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$AddPlayerRequestModel extends AddPlayerRequestModel {
  @override
  final int? positionId;
  @override
  final String name;
  @override
  final int? initialTeamId;

  factory _$AddPlayerRequestModel(
          [void Function(AddPlayerRequestModelBuilder)? updates]) =>
      (new AddPlayerRequestModelBuilder()..update(updates))._build();

  _$AddPlayerRequestModel._(
      {this.positionId, required this.name, this.initialTeamId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'AddPlayerRequestModel', 'name');
  }

  @override
  AddPlayerRequestModel rebuild(
          void Function(AddPlayerRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddPlayerRequestModelBuilder toBuilder() =>
      new AddPlayerRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddPlayerRequestModel &&
        positionId == other.positionId &&
        name == other.name &&
        initialTeamId == other.initialTeamId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, initialTeamId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddPlayerRequestModel')
          ..add('positionId', positionId)
          ..add('name', name)
          ..add('initialTeamId', initialTeamId))
        .toString();
  }
}

class AddPlayerRequestModelBuilder
    implements Builder<AddPlayerRequestModel, AddPlayerRequestModelBuilder> {
  _$AddPlayerRequestModel? _$v;

  int? _positionId;
  int? get positionId => _$this._positionId;
  set positionId(int? positionId) => _$this._positionId = positionId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _initialTeamId;
  int? get initialTeamId => _$this._initialTeamId;
  set initialTeamId(int? initialTeamId) =>
      _$this._initialTeamId = initialTeamId;

  AddPlayerRequestModelBuilder();

  AddPlayerRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _positionId = $v.positionId;
      _name = $v.name;
      _initialTeamId = $v.initialTeamId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddPlayerRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddPlayerRequestModel;
  }

  @override
  void update(void Function(AddPlayerRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddPlayerRequestModel build() => _build();

  _$AddPlayerRequestModel _build() {
    final _$result = _$v ??
        new _$AddPlayerRequestModel._(
            positionId: positionId,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'AddPlayerRequestModel', 'name'),
            initialTeamId: initialTeamId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
