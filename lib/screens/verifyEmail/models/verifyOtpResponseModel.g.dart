// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyOtpResponseModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VerifyOtpResponseModel> _$verifyOtpResponseModelSerializer =
    new _$VerifyOtpResponseModelSerializer();

class _$VerifyOtpResponseModelSerializer
    implements StructuredSerializer<VerifyOtpResponseModel> {
  @override
  final Iterable<Type> types = const [
    VerifyOtpResponseModel,
    _$VerifyOtpResponseModel
  ];
  @override
  final String wireName = 'VerifyOtpResponseModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VerifyOtpResponseModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  VerifyOtpResponseModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VerifyOtpResponseModelBuilder();

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
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$VerifyOtpResponseModel extends VerifyOtpResponseModel {
  @override
  final String email;
  @override
  final String token;
  @override
  final String message;

  factory _$VerifyOtpResponseModel(
          [void Function(VerifyOtpResponseModelBuilder)? updates]) =>
      (new VerifyOtpResponseModelBuilder()..update(updates))._build();

  _$VerifyOtpResponseModel._(
      {required this.email, required this.token, required this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'VerifyOtpResponseModel', 'email');
    BuiltValueNullFieldError.checkNotNull(
        token, r'VerifyOtpResponseModel', 'token');
    BuiltValueNullFieldError.checkNotNull(
        message, r'VerifyOtpResponseModel', 'message');
  }

  @override
  VerifyOtpResponseModel rebuild(
          void Function(VerifyOtpResponseModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyOtpResponseModelBuilder toBuilder() =>
      new VerifyOtpResponseModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyOtpResponseModel &&
        email == other.email &&
        token == other.token &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyOtpResponseModel')
          ..add('email', email)
          ..add('token', token)
          ..add('message', message))
        .toString();
  }
}

class VerifyOtpResponseModelBuilder
    implements Builder<VerifyOtpResponseModel, VerifyOtpResponseModelBuilder> {
  _$VerifyOtpResponseModel? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  VerifyOtpResponseModelBuilder();

  VerifyOtpResponseModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _token = $v.token;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyOtpResponseModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerifyOtpResponseModel;
  }

  @override
  void update(void Function(VerifyOtpResponseModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyOtpResponseModel build() => _build();

  _$VerifyOtpResponseModel _build() {
    final _$result = _$v ??
        new _$VerifyOtpResponseModel._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'VerifyOtpResponseModel', 'email'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'VerifyOtpResponseModel', 'token'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'VerifyOtpResponseModel', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
