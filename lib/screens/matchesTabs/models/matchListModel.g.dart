// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MatchListModel> _$matchListModelSerializer =
    new _$MatchListModelSerializer();

class _$MatchListModelSerializer
    implements StructuredSerializer<MatchListModel> {
  @override
  final Iterable<Type> types = const [MatchListModel, _$MatchListModel];
  @override
  final String wireName = 'MatchListModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, MatchListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(MatchModel)])),
    ];

    return result;
  }

  @override
  MatchListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MatchListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MatchModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$MatchListModel extends MatchListModel {
  @override
  final BuiltList<MatchModel> data;

  factory _$MatchListModel([void Function(MatchListModelBuilder)? updates]) =>
      (new MatchListModelBuilder()..update(updates))._build();

  _$MatchListModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'MatchListModel', 'data');
  }

  @override
  MatchListModel rebuild(void Function(MatchListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MatchListModelBuilder toBuilder() =>
      new MatchListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MatchListModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'MatchListModel')..add('data', data))
        .toString();
  }
}

class MatchListModelBuilder
    implements Builder<MatchListModel, MatchListModelBuilder> {
  _$MatchListModel? _$v;

  ListBuilder<MatchModel>? _data;
  ListBuilder<MatchModel> get data =>
      _$this._data ??= new ListBuilder<MatchModel>();
  set data(ListBuilder<MatchModel>? data) => _$this._data = data;

  MatchListModelBuilder();

  MatchListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MatchListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MatchListModel;
  }

  @override
  void update(void Function(MatchListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MatchListModel build() => _build();

  _$MatchListModel _build() {
    _$MatchListModel _$result;
    try {
      _$result = _$v ?? new _$MatchListModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MatchListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
