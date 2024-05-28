import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'responseErrorModel.g.dart';

abstract class ResponseErrorModel implements Built<ResponseErrorModel, ResponseErrorModelBuilder>{
  String get message;

  ResponseErrorModel._();

  factory ResponseErrorModel([Function(ResponseErrorModelBuilder b) updates]) = _$ResponseErrorModel;

  static Serializer<ResponseErrorModel> get serializer => _$responseErrorModelSerializer;
}