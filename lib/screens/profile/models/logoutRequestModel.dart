import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'logoutRequestModel.g.dart';

abstract class LogoutRequestModel
    implements Built<LogoutRequestModel, LogoutRequestModelBuilder> {
  @BuiltValueField(wireName: 'device_id')
  String get deviceId;

  LogoutRequestModel._();

  factory LogoutRequestModel([Function(LogoutRequestModelBuilder b) updates]) =
      _$LogoutRequestModel;

  static Serializer<LogoutRequestModel> get serializer =>
      _$logoutRequestModelSerializer;
}
