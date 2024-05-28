// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyOtpRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VerifyOtpRequestModel> _$verifyOtpRequestModelSerializer =
    new _$VerifyOtpRequestModelSerializer();

class _$VerifyOtpRequestModelSerializer
    implements StructuredSerializer<VerifyOtpRequestModel> {
  @override
  final Iterable<Type> types = const [
    VerifyOtpRequestModel,
    _$VerifyOtpRequestModel
  ];
  @override
  final String wireName = 'VerifyOtpRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VerifyOtpRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'otp',
      serializers.serialize(object.otp, specifiedType: const FullType(int)),
      'fcmToken',
      serializers.serialize(object.fcmToken,
          specifiedType: const FullType(String)),
      'device_id',
      serializers.serialize(object.deviceId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.firstName;
    if (value != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  VerifyOtpRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VerifyOtpRequestModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'otp':
          result.otp = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fcmToken':
          result.fcmToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'device_id':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$VerifyOtpRequestModel extends VerifyOtpRequestModel {
  @override
  final String email;
  @override
  final int otp;
  @override
  final String fcmToken;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String deviceId;

  factory _$VerifyOtpRequestModel(
          [void Function(VerifyOtpRequestModelBuilder)? updates]) =>
      (new VerifyOtpRequestModelBuilder()..update(updates))._build();

  _$VerifyOtpRequestModel._(
      {required this.email,
      required this.otp,
      required this.fcmToken,
      this.firstName,
      this.lastName,
      required this.deviceId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'VerifyOtpRequestModel', 'email');
    BuiltValueNullFieldError.checkNotNull(otp, r'VerifyOtpRequestModel', 'otp');
    BuiltValueNullFieldError.checkNotNull(
        fcmToken, r'VerifyOtpRequestModel', 'fcmToken');
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'VerifyOtpRequestModel', 'deviceId');
  }

  @override
  VerifyOtpRequestModel rebuild(
          void Function(VerifyOtpRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyOtpRequestModelBuilder toBuilder() =>
      new VerifyOtpRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyOtpRequestModel &&
        email == other.email &&
        otp == other.otp &&
        fcmToken == other.fcmToken &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyOtpRequestModel')
          ..add('email', email)
          ..add('otp', otp)
          ..add('fcmToken', fcmToken)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class VerifyOtpRequestModelBuilder
    implements Builder<VerifyOtpRequestModel, VerifyOtpRequestModelBuilder> {
  _$VerifyOtpRequestModel? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  int? _otp;
  int? get otp => _$this._otp;
  set otp(int? otp) => _$this._otp = otp;

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  VerifyOtpRequestModelBuilder();

  VerifyOtpRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _otp = $v.otp;
      _fcmToken = $v.fcmToken;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyOtpRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerifyOtpRequestModel;
  }

  @override
  void update(void Function(VerifyOtpRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyOtpRequestModel build() => _build();

  _$VerifyOtpRequestModel _build() {
    final _$result = _$v ??
        new _$VerifyOtpRequestModel._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'VerifyOtpRequestModel', 'email'),
            otp: BuiltValueNullFieldError.checkNotNull(
                otp, r'VerifyOtpRequestModel', 'otp'),
            fcmToken: BuiltValueNullFieldError.checkNotNull(
                fcmToken, r'VerifyOtpRequestModel', 'fcmToken'),
            firstName: firstName,
            lastName: lastName,
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'VerifyOtpRequestModel', 'deviceId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
