// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logoutRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LogoutRequestModel> _$logoutRequestModelSerializer =
    new _$LogoutRequestModelSerializer();

class _$LogoutRequestModelSerializer
    implements StructuredSerializer<LogoutRequestModel> {
  @override
  final Iterable<Type> types = const [LogoutRequestModel, _$LogoutRequestModel];
  @override
  final String wireName = 'LogoutRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, LogoutRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'device_id',
      serializers.serialize(object.deviceId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  LogoutRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LogoutRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'device_id':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LogoutRequestModel extends LogoutRequestModel {
  @override
  final String deviceId;

  factory _$LogoutRequestModel(
          [void Function(LogoutRequestModelBuilder)? updates]) =>
      (new LogoutRequestModelBuilder()..update(updates))._build();

  _$LogoutRequestModel._({required this.deviceId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'LogoutRequestModel', 'deviceId');
  }

  @override
  LogoutRequestModel rebuild(
          void Function(LogoutRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LogoutRequestModelBuilder toBuilder() =>
      new LogoutRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LogoutRequestModel && deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LogoutRequestModel')
          ..add('deviceId', deviceId))
        .toString();
  }
}

class LogoutRequestModelBuilder
    implements Builder<LogoutRequestModel, LogoutRequestModelBuilder> {
  _$LogoutRequestModel? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  LogoutRequestModelBuilder();

  LogoutRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LogoutRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LogoutRequestModel;
  }

  @override
  void update(void Function(LogoutRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LogoutRequestModel build() => _build();

  _$LogoutRequestModel _build() {
    final _$result = _$v ??
        new _$LogoutRequestModel._(
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'LogoutRequestModel', 'deviceId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
