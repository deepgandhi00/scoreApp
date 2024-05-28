// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseErrorModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ResponseErrorModel> _$responseErrorModelSerializer =
    new _$ResponseErrorModelSerializer();

class _$ResponseErrorModelSerializer
    implements StructuredSerializer<ResponseErrorModel> {
  @override
  final Iterable<Type> types = const [ResponseErrorModel, _$ResponseErrorModel];
  @override
  final String wireName = 'ResponseErrorModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ResponseErrorModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ResponseErrorModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ResponseErrorModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ResponseErrorModel extends ResponseErrorModel {
  @override
  final String message;

  factory _$ResponseErrorModel(
          [void Function(ResponseErrorModelBuilder)? updates]) =>
      (new ResponseErrorModelBuilder()..update(updates))._build();

  _$ResponseErrorModel._({required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'ResponseErrorModel', 'message');
  }

  @override
  ResponseErrorModel rebuild(
          void Function(ResponseErrorModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResponseErrorModelBuilder toBuilder() =>
      new ResponseErrorModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResponseErrorModel && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResponseErrorModel')
          ..add('message', message))
        .toString();
  }
}

class ResponseErrorModelBuilder
    implements Builder<ResponseErrorModel, ResponseErrorModelBuilder> {
  _$ResponseErrorModel? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ResponseErrorModelBuilder();

  ResponseErrorModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResponseErrorModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResponseErrorModel;
  }

  @override
  void update(void Function(ResponseErrorModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResponseErrorModel build() => _build();

  _$ResponseErrorModel _build() {
    final _$result = _$v ??
        new _$ResponseErrorModel._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'ResponseErrorModel', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
