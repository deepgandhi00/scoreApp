// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateStatusModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UpdateStatusModel> _$updateStatusModelSerializer =
    new _$UpdateStatusModelSerializer();

class _$UpdateStatusModelSerializer
    implements StructuredSerializer<UpdateStatusModel> {
  @override
  final Iterable<Type> types = const [UpdateStatusModel, _$UpdateStatusModel];
  @override
  final String wireName = 'UpdateStatusModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UpdateStatusModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'elapsedInSeconds',
      serializers.serialize(object.elapsedInSeconds,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  UpdateStatusModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdateStatusModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'elapsedInSeconds':
          result.elapsedInSeconds = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UpdateStatusModel extends UpdateStatusModel {
  @override
  final int elapsedInSeconds;

  factory _$UpdateStatusModel(
          [void Function(UpdateStatusModelBuilder)? updates]) =>
      (new UpdateStatusModelBuilder()..update(updates))._build();

  _$UpdateStatusModel._({required this.elapsedInSeconds}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        elapsedInSeconds, r'UpdateStatusModel', 'elapsedInSeconds');
  }

  @override
  UpdateStatusModel rebuild(void Function(UpdateStatusModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateStatusModelBuilder toBuilder() =>
      new UpdateStatusModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateStatusModel &&
        elapsedInSeconds == other.elapsedInSeconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, elapsedInSeconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateStatusModel')
          ..add('elapsedInSeconds', elapsedInSeconds))
        .toString();
  }
}

class UpdateStatusModelBuilder
    implements Builder<UpdateStatusModel, UpdateStatusModelBuilder> {
  _$UpdateStatusModel? _$v;

  int? _elapsedInSeconds;
  int? get elapsedInSeconds => _$this._elapsedInSeconds;
  set elapsedInSeconds(int? elapsedInSeconds) =>
      _$this._elapsedInSeconds = elapsedInSeconds;

  UpdateStatusModelBuilder();

  UpdateStatusModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _elapsedInSeconds = $v.elapsedInSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateStatusModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateStatusModel;
  }

  @override
  void update(void Function(UpdateStatusModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateStatusModel build() => _build();

  _$UpdateStatusModel _build() {
    final _$result = _$v ??
        new _$UpdateStatusModel._(
            elapsedInSeconds: BuiltValueNullFieldError.checkNotNull(
                elapsedInSeconds, r'UpdateStatusModel', 'elapsedInSeconds'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
