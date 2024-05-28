// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addPublicMatchesRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddPublicMatchesRequestModel>
    _$addPublicMatchesRequestModelSerializer =
    new _$AddPublicMatchesRequestModelSerializer();

class _$AddPublicMatchesRequestModelSerializer
    implements StructuredSerializer<AddPublicMatchesRequestModel> {
  @override
  final Iterable<Type> types = const [
    AddPublicMatchesRequestModel,
    _$AddPublicMatchesRequestModel
  ];
  @override
  final String wireName = 'AddPublicMatchesRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AddPublicMatchesRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'matches',
      serializers.serialize(object.matches,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  AddPublicMatchesRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddPublicMatchesRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'matches':
          result.matches.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$AddPublicMatchesRequestModel extends AddPublicMatchesRequestModel {
  @override
  final BuiltList<int> matches;

  factory _$AddPublicMatchesRequestModel(
          [void Function(AddPublicMatchesRequestModelBuilder)? updates]) =>
      (new AddPublicMatchesRequestModelBuilder()..update(updates))._build();

  _$AddPublicMatchesRequestModel._({required this.matches}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        matches, r'AddPublicMatchesRequestModel', 'matches');
  }

  @override
  AddPublicMatchesRequestModel rebuild(
          void Function(AddPublicMatchesRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddPublicMatchesRequestModelBuilder toBuilder() =>
      new AddPublicMatchesRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddPublicMatchesRequestModel && matches == other.matches;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, matches.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddPublicMatchesRequestModel')
          ..add('matches', matches))
        .toString();
  }
}

class AddPublicMatchesRequestModelBuilder
    implements
        Builder<AddPublicMatchesRequestModel,
            AddPublicMatchesRequestModelBuilder> {
  _$AddPublicMatchesRequestModel? _$v;

  ListBuilder<int>? _matches;
  ListBuilder<int> get matches => _$this._matches ??= new ListBuilder<int>();
  set matches(ListBuilder<int>? matches) => _$this._matches = matches;

  AddPublicMatchesRequestModelBuilder();

  AddPublicMatchesRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _matches = $v.matches.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddPublicMatchesRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddPublicMatchesRequestModel;
  }

  @override
  void update(void Function(AddPublicMatchesRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddPublicMatchesRequestModel build() => _build();

  _$AddPublicMatchesRequestModel _build() {
    _$AddPublicMatchesRequestModel _$result;
    try {
      _$result =
          _$v ?? new _$AddPublicMatchesRequestModel._(matches: matches.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'matches';
        matches.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AddPublicMatchesRequestModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
