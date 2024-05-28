// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoreTypeListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScoreTypeListModel> _$scoreTypeListModelSerializer =
    new _$ScoreTypeListModelSerializer();

class _$ScoreTypeListModelSerializer
    implements StructuredSerializer<ScoreTypeListModel> {
  @override
  final Iterable<Type> types = const [ScoreTypeListModel, _$ScoreTypeListModel];
  @override
  final String wireName = 'ScoreTypeListModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ScoreTypeListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'scoreTypes',
      serializers.serialize(object.scoreTypes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ScoreTypeModel)])),
    ];

    return result;
  }

  @override
  ScoreTypeListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScoreTypeListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'scoreTypes':
          result.scoreTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ScoreTypeModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ScoreTypeListModel extends ScoreTypeListModel {
  @override
  final BuiltList<ScoreTypeModel> scoreTypes;

  factory _$ScoreTypeListModel(
          [void Function(ScoreTypeListModelBuilder)? updates]) =>
      (new ScoreTypeListModelBuilder()..update(updates))._build();

  _$ScoreTypeListModel._({required this.scoreTypes}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        scoreTypes, r'ScoreTypeListModel', 'scoreTypes');
  }

  @override
  ScoreTypeListModel rebuild(
          void Function(ScoreTypeListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreTypeListModelBuilder toBuilder() =>
      new ScoreTypeListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreTypeListModel && scoreTypes == other.scoreTypes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scoreTypes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreTypeListModel')
          ..add('scoreTypes', scoreTypes))
        .toString();
  }
}

class ScoreTypeListModelBuilder
    implements Builder<ScoreTypeListModel, ScoreTypeListModelBuilder> {
  _$ScoreTypeListModel? _$v;

  ListBuilder<ScoreTypeModel>? _scoreTypes;
  ListBuilder<ScoreTypeModel> get scoreTypes =>
      _$this._scoreTypes ??= new ListBuilder<ScoreTypeModel>();
  set scoreTypes(ListBuilder<ScoreTypeModel>? scoreTypes) =>
      _$this._scoreTypes = scoreTypes;

  ScoreTypeListModelBuilder();

  ScoreTypeListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scoreTypes = $v.scoreTypes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreTypeListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScoreTypeListModel;
  }

  @override
  void update(void Function(ScoreTypeListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreTypeListModel build() => _build();

  _$ScoreTypeListModel _build() {
    _$ScoreTypeListModel _$result;
    try {
      _$result =
          _$v ?? new _$ScoreTypeListModel._(scoreTypes: scoreTypes.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'scoreTypes';
        scoreTypes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ScoreTypeListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
