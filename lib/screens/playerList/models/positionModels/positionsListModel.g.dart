// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positionsListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PositionsListModel> _$positionsListModelSerializer =
    new _$PositionsListModelSerializer();

class _$PositionsListModelSerializer
    implements StructuredSerializer<PositionsListModel> {
  @override
  final Iterable<Type> types = const [PositionsListModel, _$PositionsListModel];
  @override
  final String wireName = 'PositionsListModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, PositionsListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PositionsModel)])),
    ];

    return result;
  }

  @override
  PositionsListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PositionsListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PositionsModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$PositionsListModel extends PositionsListModel {
  @override
  final BuiltList<PositionsModel> data;

  factory _$PositionsListModel(
          [void Function(PositionsListModelBuilder)? updates]) =>
      (new PositionsListModelBuilder()..update(updates))._build();

  _$PositionsListModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'PositionsListModel', 'data');
  }

  @override
  PositionsListModel rebuild(
          void Function(PositionsListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionsListModelBuilder toBuilder() =>
      new PositionsListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PositionsListModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'PositionsListModel')
          ..add('data', data))
        .toString();
  }
}

class PositionsListModelBuilder
    implements Builder<PositionsListModel, PositionsListModelBuilder> {
  _$PositionsListModel? _$v;

  ListBuilder<PositionsModel>? _data;
  ListBuilder<PositionsModel> get data =>
      _$this._data ??= new ListBuilder<PositionsModel>();
  set data(ListBuilder<PositionsModel>? data) => _$this._data = data;

  PositionsListModelBuilder();

  PositionsListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PositionsListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PositionsListModel;
  }

  @override
  void update(void Function(PositionsListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PositionsListModel build() => _build();

  _$PositionsListModel _build() {
    _$PositionsListModel _$result;
    try {
      _$result = _$v ?? new _$PositionsListModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PositionsListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
