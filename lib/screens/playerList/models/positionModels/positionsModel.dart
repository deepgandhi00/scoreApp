import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'positionsModel.g.dart';

abstract class PositionsModel implements Built<PositionsModel, PositionsModelBuilder> {
  int? get position_id;
  String get name;

  PositionsModel._();

  factory PositionsModel([Function(PositionsModelBuilder b) updates]) = _$PositionsModel;

  static Serializer<PositionsModel> get serializer => _$positionsModelSerializer;
}