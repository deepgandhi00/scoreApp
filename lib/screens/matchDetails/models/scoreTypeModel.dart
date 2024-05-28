import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scoreTypeModel.g.dart';

abstract class ScoreTypeModel implements Built<ScoreTypeModel, ScoreTypeModelBuilder> {
  int get score_type_id;
  String get name;

  ScoreTypeModel._();

  factory ScoreTypeModel([Function(ScoreTypeModelBuilder b) updates]) = _$ScoreTypeModel;

  static Serializer<ScoreTypeModel> get serializer => _$scoreTypeModelSerializer;
}