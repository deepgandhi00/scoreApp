// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generateOtpRequestModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GenerateOtpRequestModel> _$generateOtpRequestModelSerializer =
    new _$GenerateOtpRequestModelSerializer();

class _$GenerateOtpRequestModelSerializer
    implements StructuredSerializer<GenerateOtpRequestModel> {
  @override
  final Iterable<Type> types = const [
    GenerateOtpRequestModel,
    _$GenerateOtpRequestModel
  ];
  @override
  final String wireName = 'GenerateOtpRequestModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GenerateOtpRequestModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GenerateOtpRequestModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GenerateOtpRequestModelBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GenerateOtpRequestModel extends GenerateOtpRequestModel {
  @override
  final String email;

  factory _$GenerateOtpRequestModel(
          [void Function(GenerateOtpRequestModelBuilder)? updates]) =>
      (new GenerateOtpRequestModelBuilder()..update(updates))._build();

  _$GenerateOtpRequestModel._({required this.email}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'GenerateOtpRequestModel', 'email');
  }

  @override
  GenerateOtpRequestModel rebuild(
          void Function(GenerateOtpRequestModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateOtpRequestModelBuilder toBuilder() =>
      new GenerateOtpRequestModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateOtpRequestModel && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateOtpRequestModel')
          ..add('email', email))
        .toString();
  }
}

class GenerateOtpRequestModelBuilder
    implements
        Builder<GenerateOtpRequestModel, GenerateOtpRequestModelBuilder> {
  _$GenerateOtpRequestModel? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GenerateOtpRequestModelBuilder();

  GenerateOtpRequestModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateOtpRequestModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenerateOtpRequestModel;
  }

  @override
  void update(void Function(GenerateOtpRequestModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateOtpRequestModel build() => _build();

  _$GenerateOtpRequestModel _build() {
    final _$result = _$v ??
        new _$GenerateOtpRequestModel._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GenerateOtpRequestModel', 'email'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
