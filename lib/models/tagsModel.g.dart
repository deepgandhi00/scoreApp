// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagsModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TagsModel> _$tagsModelSerializer = new _$TagsModelSerializer();

class _$TagsModelSerializer implements StructuredSerializer<TagsModel> {
  @override
  final Iterable<Type> types = const [TagsModel, _$TagsModel];
  @override
  final String wireName = 'TagsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TagsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.tagId;
    if (value != null) {
      result
        ..add('tag_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  TagsModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TagsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tag_id':
          result.tagId = serializers.deserialize(value,
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

class _$TagsModel extends TagsModel {
  @override
  final int? tagId;
  @override
  final String name;

  factory _$TagsModel([void Function(TagsModelBuilder)? updates]) =>
      (new TagsModelBuilder()..update(updates))._build();

  _$TagsModel._({this.tagId, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'TagsModel', 'name');
  }

  @override
  TagsModel rebuild(void Function(TagsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TagsModelBuilder toBuilder() => new TagsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TagsModel && tagId == other.tagId && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TagsModel')
          ..add('tagId', tagId)
          ..add('name', name))
        .toString();
  }
}

class TagsModelBuilder implements Builder<TagsModel, TagsModelBuilder> {
  _$TagsModel? _$v;

  int? _tagId;
  int? get tagId => _$this._tagId;
  set tagId(int? tagId) => _$this._tagId = tagId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TagsModelBuilder();

  TagsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TagsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TagsModel;
  }

  @override
  void update(void Function(TagsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TagsModel build() => _build();

  _$TagsModel _build() {
    final _$result = _$v ??
        new _$TagsModel._(
            tagId: tagId,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TagsModel', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
