// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagsListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TagsListModel> _$tagsListModelSerializer =
    new _$TagsListModelSerializer();

class _$TagsListModelSerializer implements StructuredSerializer<TagsListModel> {
  @override
  final Iterable<Type> types = const [TagsListModel, _$TagsListModel];
  @override
  final String wireName = 'TagsListModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TagsListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TagsModel)])),
    ];

    return result;
  }

  @override
  TagsListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TagsListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TagsModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TagsListModel extends TagsListModel {
  @override
  final BuiltList<TagsModel> data;

  factory _$TagsListModel([void Function(TagsListModelBuilder)? updates]) =>
      (new TagsListModelBuilder()..update(updates))._build();

  _$TagsListModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TagsListModel', 'data');
  }

  @override
  TagsListModel rebuild(void Function(TagsListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TagsListModelBuilder toBuilder() => new TagsListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TagsListModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TagsListModel')..add('data', data))
        .toString();
  }
}

class TagsListModelBuilder
    implements Builder<TagsListModel, TagsListModelBuilder> {
  _$TagsListModel? _$v;

  ListBuilder<TagsModel>? _data;
  ListBuilder<TagsModel> get data =>
      _$this._data ??= new ListBuilder<TagsModel>();
  set data(ListBuilder<TagsModel>? data) => _$this._data = data;

  TagsListModelBuilder();

  TagsListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TagsListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TagsListModel;
  }

  @override
  void update(void Function(TagsListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TagsListModel build() => _build();

  _$TagsListModel _build() {
    _$TagsListModel _$result;
    try {
      _$result = _$v ?? new _$TagsListModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TagsListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
