import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:built_collection/built_collection.dart';

part 'addGoalModel.g.dart';

abstract class AddGoalModel implements Built<AddGoalModel, AddGoalModelBuilder> {
  int? get playerId;
  int? get assistPlayerId;
  int? get scoreTypeId;
  bool get isSecondaryTeam;
  int get mins;

  AddGoalModel._();

  factory AddGoalModel([Function(AddGoalModelBuilder b) updates]) = _$AddGoalModel;

  static Serializer<AddGoalModel> get serializer => _$addGoalModelSerializer;
}