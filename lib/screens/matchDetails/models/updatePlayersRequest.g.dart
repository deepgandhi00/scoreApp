// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updatePlayersRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UpdatePlayersRequest> _$updatePlayersRequestSerializer =
    new _$UpdatePlayersRequestSerializer();

class _$UpdatePlayersRequestSerializer
    implements StructuredSerializer<UpdatePlayersRequest> {
  @override
  final Iterable<Type> types = const [
    UpdatePlayersRequest,
    _$UpdatePlayersRequest
  ];
  @override
  final String wireName = 'UpdatePlayersRequest';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UpdatePlayersRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'lineups',
      serializers.serialize(object.lineups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
      'substitutes',
      serializers.serialize(object.substitutes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  UpdatePlayersRequest deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdatePlayersRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lineups':
          result.lineups.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'substitutes':
          result.substitutes.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$UpdatePlayersRequest extends UpdatePlayersRequest {
  @override
  final BuiltList<int> lineups;
  @override
  final BuiltList<int> substitutes;

  factory _$UpdatePlayersRequest(
          [void Function(UpdatePlayersRequestBuilder)? updates]) =>
      (new UpdatePlayersRequestBuilder()..update(updates))._build();

  _$UpdatePlayersRequest._({required this.lineups, required this.substitutes})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        lineups, r'UpdatePlayersRequest', 'lineups');
    BuiltValueNullFieldError.checkNotNull(
        substitutes, r'UpdatePlayersRequest', 'substitutes');
  }

  @override
  UpdatePlayersRequest rebuild(
          void Function(UpdatePlayersRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePlayersRequestBuilder toBuilder() =>
      new UpdatePlayersRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePlayersRequest &&
        lineups == other.lineups &&
        substitutes == other.substitutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lineups.hashCode);
    _$hash = $jc(_$hash, substitutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePlayersRequest')
          ..add('lineups', lineups)
          ..add('substitutes', substitutes))
        .toString();
  }
}

class UpdatePlayersRequestBuilder
    implements Builder<UpdatePlayersRequest, UpdatePlayersRequestBuilder> {
  _$UpdatePlayersRequest? _$v;

  ListBuilder<int>? _lineups;
  ListBuilder<int> get lineups => _$this._lineups ??= new ListBuilder<int>();
  set lineups(ListBuilder<int>? lineups) => _$this._lineups = lineups;

  ListBuilder<int>? _substitutes;
  ListBuilder<int> get substitutes =>
      _$this._substitutes ??= new ListBuilder<int>();
  set substitutes(ListBuilder<int>? substitutes) =>
      _$this._substitutes = substitutes;

  UpdatePlayersRequestBuilder();

  UpdatePlayersRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lineups = $v.lineups.toBuilder();
      _substitutes = $v.substitutes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePlayersRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdatePlayersRequest;
  }

  @override
  void update(void Function(UpdatePlayersRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePlayersRequest build() => _build();

  _$UpdatePlayersRequest _build() {
    _$UpdatePlayersRequest _$result;
    try {
      _$result = _$v ??
          new _$UpdatePlayersRequest._(
              lineups: lineups.build(), substitutes: substitutes.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lineups';
        lineups.build();
        _$failedField = 'substitutes';
        substitutes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UpdatePlayersRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
