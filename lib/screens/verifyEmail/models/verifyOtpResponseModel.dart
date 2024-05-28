import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verifyOtpResponseModel.g.dart';

abstract class VerifyOtpResponseModel implements Built<VerifyOtpResponseModel, VerifyOtpResponseModelBuilder> {
  String get email;
  String get token;
  String get message;

  VerifyOtpResponseModel._();

  factory VerifyOtpResponseModel([Function(VerifyOtpResponseModelBuilder b) updates]) = _$VerifyOtpResponseModel;

  static Serializer<VerifyOtpResponseModel> get serializer => _$verifyOtpResponseModelSerializer;
}