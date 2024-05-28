// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goalResponseModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GoalResponseModel> _$goalResponseModelSerializer =
    new _$GoalResponseModelSerializer();

class _$GoalResponseModelSerializer
    implements StructuredSerializer<GoalResponseModel> {
  @override
  final Iterable<Type> types = const [GoalResponseModel, _$GoalResponseModel];
  @override
  final String wireName = 'GoalResponseModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, GoalResponseModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(GoalModel)),
    ];

    return result;
  }

  @override
  GoalResponseModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GoalResponseModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(GoalModel))! as GoalModel);
          break;
      }
    }

    return result.build();
  }
}

class _$GoalResponseModel extends GoalResponseModel {
  @override
  final GoalModel data;

  factory _$GoalResponseModel(
          [void Function(GoalResponseModelBuilder)? updates]) =>
      (new GoalResponseModelBuilder()..update(updates))._build();

  _$GoalResponseModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'GoalResponseModel', 'data');
  }

  @override
  GoalResponseModel rebuild(void Function(GoalResponseModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalResponseModelBuilder toBuilder() =>
      new GoalResponseModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoalResponseModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GoalResponseModel')
          ..add('data', data))
        .toString();
  }
}

class GoalResponseModelBuilder
    implements Builder<GoalResponseModel, GoalResponseModelBuilder> {
  _$GoalResponseModel? _$v;

  GoalModelBuilder? _data;
  GoalModelBuilder get data => _$this._data ??= new GoalModelBuilder();
  set data(GoalModelBuilder? data) => _$this._data = data;

  GoalResponseModelBuilder();

  GoalResponseModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoalResponseModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GoalResponseModel;
  }

  @override
  void update(void Function(GoalResponseModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GoalResponseModel build() => _build();

  _$GoalResponseModel _build() {
    _$GoalResponseModel _$result;
    try {
      _$result = _$v ?? new _$GoalResponseModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GoalResponseModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
