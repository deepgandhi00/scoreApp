// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoreTypeModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScoreTypeModel> _$scoreTypeModelSerializer =
    new _$ScoreTypeModelSerializer();

class _$ScoreTypeModelSerializer
    implements StructuredSerializer<ScoreTypeModel> {
  @override
  final Iterable<Type> types = const [ScoreTypeModel, _$ScoreTypeModel];
  @override
  final String wireName = 'ScoreTypeModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ScoreTypeModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'score_type_id',
      serializers.serialize(object.score_type_id,
          specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ScoreTypeModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScoreTypeModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'score_type_id':
          result.score_type_id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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

class _$ScoreTypeModel extends ScoreTypeModel {
  @override
  final int score_type_id;
  @override
  final String name;

  factory _$ScoreTypeModel([void Function(ScoreTypeModelBuilder)? updates]) =>
      (new ScoreTypeModelBuilder()..update(updates))._build();

  _$ScoreTypeModel._({required this.score_type_id, required this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        score_type_id, r'ScoreTypeModel', 'score_type_id');
    BuiltValueNullFieldError.checkNotNull(name, r'ScoreTypeModel', 'name');
  }

  @override
  ScoreTypeModel rebuild(void Function(ScoreTypeModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreTypeModelBuilder toBuilder() =>
      new ScoreTypeModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreTypeModel &&
        score_type_id == other.score_type_id &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score_type_id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreTypeModel')
          ..add('score_type_id', score_type_id)
          ..add('name', name))
        .toString();
  }
}

class ScoreTypeModelBuilder
    implements Builder<ScoreTypeModel, ScoreTypeModelBuilder> {
  _$ScoreTypeModel? _$v;

  int? _score_type_id;
  int? get score_type_id => _$this._score_type_id;
  set score_type_id(int? score_type_id) =>
      _$this._score_type_id = score_type_id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ScoreTypeModelBuilder();

  ScoreTypeModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score_type_id = $v.score_type_id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreTypeModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScoreTypeModel;
  }

  @override
  void update(void Function(ScoreTypeModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreTypeModel build() => _build();

  _$ScoreTypeModel _build() {
    final _$result = _$v ??
        new _$ScoreTypeModel._(
            score_type_id: BuiltValueNullFieldError.checkNotNull(
                score_type_id, r'ScoreTypeModel', 'score_type_id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'ScoreTypeModel', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
