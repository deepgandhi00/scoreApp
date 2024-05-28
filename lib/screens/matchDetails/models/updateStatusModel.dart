import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'updateStatusModel.g.dart';

abstract class UpdateStatusModel implements Built<UpdateStatusModel, UpdateStatusModelBuilder> {
  int get elapsedInSeconds;

  UpdateStatusModel._();

  factory UpdateStatusModel([Function(UpdateStatusModelBuilder b) updates]) = _$UpdateStatusModel;

  static Serializer<UpdateStatusModel> get serializer => _$updateStatusModelSerializer;
}