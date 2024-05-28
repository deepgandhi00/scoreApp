// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TeamListModel> _$teamListModelSerializer =
    new _$TeamListModelSerializer();

class _$TeamListModelSerializer implements StructuredSerializer<TeamListModel> {
  @override
  final Iterable<Type> types = const [TeamListModel, _$TeamListModel];
  @override
  final String wireName = 'TeamListModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TeamListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TeamModel)])),
    ];

    return result;
  }

  @override
  TeamListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TeamListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TeamModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TeamListModel extends TeamListModel {
  @override
  final BuiltList<TeamModel> data;

  factory _$TeamListModel([void Function(TeamListModelBuilder)? updates]) =>
      (new TeamListModelBuilder()..update(updates))._build();

  _$TeamListModel._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'TeamListModel', 'data');
  }

  @override
  TeamListModel rebuild(void Function(TeamListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeamListModelBuilder toBuilder() => new TeamListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeamListModel && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TeamListModel')..add('data', data))
        .toString();
  }
}

class TeamListModelBuilder
    implements Builder<TeamListModel, TeamListModelBuilder> {
  _$TeamListModel? _$v;

  ListBuilder<TeamModel>? _data;
  ListBuilder<TeamModel> get data =>
      _$this._data ??= new ListBuilder<TeamModel>();
  set data(ListBuilder<TeamModel>? data) => _$this._data = data;

  TeamListModelBuilder();

  TeamListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeamListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TeamListModel;
  }

  @override
  void update(void Function(TeamListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeamListModel build() => _build();

  _$TeamListModel _build() {
    _$TeamListModel _$result;
    try {
      _$result = _$v ?? new _$TeamListModel._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TeamListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
