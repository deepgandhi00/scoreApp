import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generateOtpRequestModel.g.dart';

abstract class GenerateOtpRequestModel implements Built<GenerateOtpRequestModel, GenerateOtpRequestModelBuilder>{
  String get email;

  GenerateOtpRequestModel._();

  factory GenerateOtpRequestModel([Function(GenerateOtpRequestModelBuilder b) updates]) = _$GenerateOtpRequestModel;

  static Serializer<GenerateOtpRequestModel> get serializer => _$generateOtpRequestModelSerializer;
}