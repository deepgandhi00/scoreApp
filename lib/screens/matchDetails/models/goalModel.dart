import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:built_collection/built_collection.dart';

part 'goalModel.g.dart';

abstract class GoalModel implements Built<GoalModel, GoalModelBuilder> {
  int get goalId;
  int get matchId;
  int? get playerId;
  String? get playerName;
  String? get position;
  int? get assistPlayerId;
  String? get assistPlayerName;
  int? get scoreTypeId;
  int get isSecondaryTeam;
  int get mins;
  String get secondaryTeamName;
  String? get scoreType;
  int? get primaryGoalCount;
  int? get secondaryGoalCount;

  GoalModel._();

  factory GoalModel([Function(GoalModelBuilder b) updates]) = _$GoalModel;

  static Serializer<GoalModel> get serializer => _$goalModelSerializer;
}