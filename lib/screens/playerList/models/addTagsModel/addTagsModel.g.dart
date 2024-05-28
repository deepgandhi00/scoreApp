// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addTagsModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddTagsModel> _$addTagsModelSerializer =
    new _$AddTagsModelSerializer();

class _$AddTagsModelSerializer implements StructuredSerializer<AddTagsModel> {
  @override
  final Iterable<Type> types = const [AddTagsModel, _$AddTagsModel];
  @override
  final String wireName = 'AddTagsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, AddTagsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tags',
      serializers.serialize(object.tags,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  AddTagsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddTagsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$AddTagsModel extends AddTagsModel {
  @override
  final BuiltList<String> tags;

  factory _$AddTagsModel([void Function(AddTagsModelBuilder)? updates]) =>
      (new AddTagsModelBuilder()..update(updates))._build();

  _$AddTagsModel._({required this.tags}) : super._() {
    BuiltValueNullFieldError.checkNotNull(tags, r'AddTagsModel', 'tags');
  }

  @override
  AddTagsModel rebuild(void Function(AddTagsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddTagsModelBuilder toBuilder() => new AddTagsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddTagsModel && tags == other.tags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddTagsModel')..add('tags', tags))
        .toString();
  }
}

class AddTagsModelBuilder
    implements Builder<AddTagsModel, AddTagsModelBuilder> {
  _$AddTagsModel? _$v;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  AddTagsModelBuilder();

  AddTagsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tags = $v.tags.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddTagsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddTagsModel;
  }

  @override
  void update(void Function(AddTagsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddTagsModel build() => _build();

  _$AddTagsModel _build() {
    _$AddTagsModel _$result;
    try {
      _$result = _$v ?? new _$AddTagsModel._(tags: tags.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AddTagsModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
