import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:built_collection/built_collection.dart';

part 'positionsListModel.g.dart';

abstract class PositionsListModel implements Built<PositionsListModel, PositionsListModelBuilder> {
  BuiltList<PositionsModel> get data;

  PositionsListModel._();

  factory PositionsListModel([Function(PositionsListModelBuilder b) updates]) = _$PositionsListModel;

  static Serializer<PositionsListModel> get serializer => _$positionsListModelSerializer;
}