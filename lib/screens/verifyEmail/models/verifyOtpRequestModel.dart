import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verifyOtpRequestModel.g.dart';

abstract class VerifyOtpRequestModel
    implements Built<VerifyOtpRequestModel, VerifyOtpRequestModelBuilder> {
  String get email;

  int get otp;

  String get fcmToken;

  String? get firstName;

  String? get lastName;

  @BuiltValueField(wireName: 'device_id')
  String get deviceId;

  VerifyOtpRequestModel._();

  factory VerifyOtpRequestModel(
          [Function(VerifyOtpRequestModelBuilder b) updates]) =
      _$VerifyOtpRequestModel;

  static Serializer<VerifyOtpRequestModel> get serializer =>
      _$verifyOtpRequestModelSerializer;
}
